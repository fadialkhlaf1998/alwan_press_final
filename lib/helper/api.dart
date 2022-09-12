import 'dart:convert';

import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/model/order.dart';
import 'package:alwan_press/model/product.dart';
import 'package:alwan_press/model/product_list.dart';
import 'package:alwan_press/model/start_up.dart';
import 'package:alwan_press/model/user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;


class Api {

  static var url = "https://phpstack-548447-2874045.cloudwaysapps.com/";

  static Future checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.mobile) {
      return true;
    }else if(result == ConnectivityResult.wifi) {
      return true;
    }else if(result == ConnectivityResult.ethernet){
      return true;
    }else if(result == ConnectivityResult.bluetooth){
      return true;
    }else if(result == ConnectivityResult.none){
      print("No internet connection");
      return false;
    }
  }

  static Future getStartUpData() async {
    print('request begin');
    var request = http.Request('GET', Uri.parse(url + 'api/new/start-up'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      print(data);
      return StartUp.fromMap(jsonDecode(data));
    }
    else {
     return StartUp(categories: [], customerService: [], banners: [],suggestionSearch: []);
    }

  }

  static Future<Product> getProductDetails(int productId) async {
    var request = http.MultipartRequest('GET', Uri.parse(url + 'api/product/$productId'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      return Product.fromJson(jsonDecode(data));
    }
    else {
      return Product(id: -1, subCategoryId: -1, title: "", subTitle: "", search: "", image: "", rate: 0, rateCount: 0, description: "", price: -1, images: [], reviews: []);
    }
  }

  static Future<List<ProductList>> getProductList(int subCategoryId) async {
    var request = http.Request('GET', Uri.parse(url + 'api/sub-category/$subCategoryId/product'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      var list = jsonDecode(data) as List;
      List<ProductList> products = <ProductList>[];
      for(var c in list){
        products.add(ProductList.fromMap(c));
      }
      return products;
    }
    else {
      return [];
    }
  }

  static Future<List<ProductList>> getSearchResult(String query) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + 'api/product/search'));
    request.body = json.encode({
      "query": query
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      var list = jsonDecode(data) as List;
      List<ProductList> products = <ProductList>[];
      for(var c in list){
        products.add(ProductList.fromMap(c));
      }
      return products;
    }
    else {
      return [];
    }

  }


  static Future<User> login(String username, String password) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + 'api/customer-login'));
    request.body = json.encode({
      "username": username,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonData = await response.stream.bytesToString();
      if(jsonData.length < 3){
        /// alert (username and password is wrong)
        return User(id: -1, quickBookId: "", name: "", token: "",
            financialState: "", username: "", password:"", address1: "", address2: "", emirate: "", apartment: "", phone: "") ;
      }else{
        jsonData = jsonData.replaceRange(0,1, '');
        jsonData = jsonData.replaceRange(jsonData.length -1 ,jsonData.length ,'');
        print(jsonData);
        User user = User.fromMap(jsonDecode(jsonData));
        print(user.name);
        Global.user = user;
        Global.userId = user.id;
        Global.password = user.password;
        Global.username = user.username;
        if(Global.token.isNotEmpty&&Global.token != user.token){
          sendUserToken(Global.token, user.id);
        }
        return user;
      }
    } else {
      /// alert (something went wrong)
      return User(id: -2, quickBookId: "", name: "", token: "",
          financialState: "", username: "", password:"", address1: "", address2: "", emirate: "", apartment: "", phone: "") ;
    }

  }

  static Future<List<Order>> getCustomerOrder(String userId) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + 'api/customer-order'));
    request.body = json.encode({
      "id": userId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      var list = jsonDecode(data) as List;
      List<Order> orders = <Order>[];
      for(var o in list){
        orders.add(Order.fromMap(o));
      }
      return orders;
    }
    else {
      return [];
    }

  }

  static Future setCustomerAddress(String address1, String address2, String emirate, String apartment, String phone, String userId) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + 'api/customer-address'));
    request.body = json.encode({
      "address1": address1,
      "address2": address2,
      "emirate": emirate,
      "apartment" : apartment,
      "phone": phone,
      "id": userId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }

  static Future sendUserToken(token, userId) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + 'api/customer/token'));
    request.body = json.encode({
      "token": token,
      "id": userId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }

  static Future<bool> requestStatement(String note, int userId) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'api/request-statment'));
    request.body = json.encode({
      "customer_id": userId,
      "notes": note
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }


  }

  static Future<bool> requestShipping(String nick_name, String street_name,String building, String floor,
      String flat, String additional_description,String phone, int order_id) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'api/shipping-request2'));
    request.body = json.encode({
      "nick_name": nick_name,
      "street_name": street_name,
      "building": street_name,
      "floor": floor,
      "flat": flat,
      "additional_description": additional_description,
      "phone": "+971"+phone,
      "order_id": order_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future<Order?> getOrderInfo(int id)async{

    var request = http.Request('GET', Uri.parse(url+'/api/order-info/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      String data = await response.stream.bytesToString();
      print('data');
      print(data);
      return Order.fromJson(data);
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static Future<bool> pay(int order_id,double amount)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('http://localhost:3000/api/pay'));
    request.body = json.encode({
      "id": order_id,
      "amount": amount,
      "secrit": "FadiAlKlaF1998AlwanMaXaRt2022"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
    print(response.reasonPhrase);
    return false;
    }

  }

  static reOrder(int customer_id,int order_id)async{
    print('************'+order_id.toString());
    print('************'+customer_id.toString());
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/re-order'));
    request.body = json.encode({
      "customer_id": customer_id,
      "order_id": order_id,
      "notes": "I need this order"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
    print(response.reasonPhrase);
      return false;
    }

  }
}