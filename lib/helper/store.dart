import 'dart:convert';

import 'package:alwan_press/helper/global.dart';
import 'package:alwan_press/model/address.dart';
import 'package:alwan_press/view/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static saveTheme(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("light", val);
  }

  static Future<bool> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("light") ?? true;
  }

  static saveAddress(Address address)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("address", address.toJson());
  }

  static Future<Address> loadAddress()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String addStr = prefs.getString("address")??"non";
    print(addStr);
    if(addStr != "non"){

      var json = jsonDecode(addStr);
      Address a = Address.fromMap(json);
      Global.nick_name = a.nickName;
      Global.street_name = a.streetName;
      Global.building = a.building;
      Global.floor = a.floor;
      Global.flat = a.flat;
      Global.phone = a.phone;
      Global.ad_desc = a.adDesc;
      return a;
    }else{
      return Address(nickName: "", streetName: "", building: "", floor: "", flat: "", adDesc: "", phone: "");
    }
  }
}