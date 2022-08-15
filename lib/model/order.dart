// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

import 'package:alwan_press/app_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<Order> orderFromMap(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromMap(x)));

String orderToMap(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Order {
  Order({
    required this.id,
    required this.quickBookId,
    required this.deadline,
    required this.customerId,
    required this.state,
    required this.title,
    required this.description,
    required this.price,
    required this.shippingState,
    required this.shippingPrice,
    required this.address,
    required this.invoice,
    required this.orderId,
    required this.shippingRequestCount,
    required this.ready,
  });

  int id;
  String quickBookId;
  DateTime deadline;
  int customerId;
  int state;
  String title;
  String description;
  int price;
  int shippingState;
  int shippingPrice;
  String address;
  String invoice;
  String orderId;
  int shippingRequestCount;
  RxBool ready = false.obs;
  String orderState = '';
  RxBool openDescription = false.obs;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["id"],
    quickBookId: json["quick_book_id"] ?? -1,
    deadline: DateTime.parse(json["deadline"] ?? ""),
    customerId: json["customer_id"] ?? -1,
    state: json["state"] ?? -1,
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    price: json["price"] ?? -1,
    shippingState: json["shipping_state"] ?? -1,
    shippingPrice: json["shipping_price"] ?? -1,
    address: json["address"] ?? "",
    invoice: json["invoice"] ?? "",
    orderId: json["order_id"] ?? -1,
    shippingRequestCount: json["shipping_request_count"] ?? -1,
    ready: DateTime.now().isBefore(DateTime.parse(json["deadline"] ?? ""))?true.obs:false.obs
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "quick_book_id": quickBookId,
    "deadline": deadline.toIso8601String(),
    "customer_id": customerId,
    "state": state,
    "title": title,
    "description": description,
    "price": price,
    "shipping_state": shippingState,
    "shipping_price": shippingPrice,
    "address": address,
    "invoice": invoice,
    "order_id": orderId,
    "shipping_request_count": shippingRequestCount,
  };
  getState(BuildContext context) {
    return App_Localization.of(context).translate("state" + state.toString());
  }

  // factory Order.fromJson(Map<String, dynamic> json) => Order(
  //   id: json["id"],
  //   quickBookId: json["quick_book_id"],
  //   deadline: DateTime.parse(json["deadline"]),
  //   customerId: json["customer_id"],
  //   state: json["state"],
  //   title: json["title"],
  //   description: json["description"],
  //   price: json["price"],
  //   shippingState: json["shipping_state"],
  //   shippingPrice: json["shipping_price"],
  //   address: json["address"],
  //   invoice: json["invoice"],
  //   orderId: json["order_id"],
  //   shippingRequestCount: json["shipping_request_count"],
  //
  // );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quick_book_id": quickBookId,
    "deadline": deadline.toIso8601String(),
    "customer_id": customerId,
    "state": state,
    "title": title,
    "description": description,
    "price": price,
    "shipping_state": shippingState,
    "shipping_price": shippingPrice,
    "address": address,
    "invoice": invoice,
    "order_id": orderId,
    "shipping_request_count": shippingRequestCount,
  };

}
