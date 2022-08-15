// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class User {
  User({
    required this.id,
    required this.quickBookId,
    required this.name,
    required this.token,
    required this.financialState,
    required this.username,
    required this.password,
    required this.address1,
    required this.address2,
    required this.emirate,
    required this.apartment,
    required this.phone,
  });

  int id;
  String quickBookId;
  String name;
  dynamic token;
  String financialState;
  String username;
  String password;
  dynamic address1;
  dynamic address2;
  dynamic emirate;
  dynamic apartment;
  dynamic phone;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    quickBookId: json["quick_book_id"],
    name: json["name"],
    token: json["token"],
    financialState: json["financial_state"],
    username: json["username"],
    password: json["password"],
    address1: json["address1"],
    address2: json["address2"],
    emirate: json["emirate"],
    apartment: json["apartment"],
    phone: json["phone"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "quick_book_id": quickBookId,
    "name": name,
    "token": token,
    "financial_state": financialState,
    "username": username,
    "password": password,
    "address1": address1,
    "address2": address2,
    "emirate": emirate,
    "apartment": apartment,
    "phone": phone,
  };
}
