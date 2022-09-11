// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

import 'package:alwan_press/app_localization.dart';
import 'package:flutter/material.dart';
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
    required this.invoice,
    required this.orderId,
    required this.pickUp,
    required this.created_at,
    required this.paid_amount,
    required this.customer,
    required this.shippingRequestCount,
    required this.shippingAddress,
    required this.ready,
  });

  int id;
  RxBool ready = false.obs;
  String quickBookId;
  DateTime deadline;
  int customerId;
  int shippingRequestCount;
  int state;
  String title;
  String description;
  int price;
  int shippingState;
  int shippingPrice;
  String invoice;
  String orderId;
  int pickUp;
  DateTime created_at;
  double paid_amount;
  String customer;
  ShippingAddress? shippingAddress;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["id"],
    quickBookId: json["quick_book_id"],
    deadline: DateTime.parse(json["deadline"]),
    customerId: json["customer_id"],
    state: json["state"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    shippingState: json["shipping_state"],
    shippingPrice: json["shipping_price"],
    invoice: json["invoice"],
    orderId: json["order_id"],
    pickUp: json["pick_up"],
    shippingRequestCount: json["shipping_request_count"],
    created_at: DateTime.parse(json["created_at"]),
    paid_amount: json["paid_amount"].toDouble(),
    customer: json["customer"]??"",
    shippingAddress:json["shipping_address"] == null ?null : ShippingAddress.fromMap(json["shipping_address"]),
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
    "invoice": invoice,
    "order_id": orderId,
    "pick_up": pickUp,
    "created_at": created_at.toIso8601String(),
    "paid_amount": paid_amount,
    "customer": customer,
    "shipping_address": shippingAddress!.toMap(),
  };


  getState(BuildContext context) {
    return App_Localization.of(context).translate("state" + state.toString());
  }
  getStateManual(BuildContext context,int state) {
    return App_Localization.of(context).translate("state" + state.toString());
  }

}

class ShippingAddress {
  ShippingAddress({
    required this.id,
    required this.nickName,
    required this.streetName,
    required this.building,
    required this.floor,
    required this.flat,
    required this.additionalDescription,
    required this.phone,
    required this.state,
    required this.orderId,
    required this.customer,
    required this.orderId2,
  });

  int id;
  String nickName;
  String streetName;
  String building;
  String floor;
  String flat;
  String additionalDescription;
  String phone;
  int state;
  int orderId;
  String customer;
  String orderId2;

  factory ShippingAddress.fromJson(String str) => ShippingAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingAddress.fromMap(Map<String, dynamic> json) => ShippingAddress(
    id: json["id"],
    nickName: json["nick_name"],
    streetName: json["street_name"],
    building: json["building"],
    floor: json["floor"],
    flat: json["flat"],
    additionalDescription: json["additional_description"],
    phone: json["phone"],
    state: json["state"],
    orderId: json["order_id"],
    customer: json["customer"],
    orderId2: json["order_id2"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nick_name": nickName,
    "street_name": streetName,
    "building": building,
    "floor": floor,
    "flat": flat,
    "additional_description": additionalDescription,
    "phone": phone,
    "state": state,
    "order_id": orderId,
    "customer": customer,
    "order_id2": orderId2,
  };
}

