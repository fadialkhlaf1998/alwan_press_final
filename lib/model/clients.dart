// To parse this JSON data, do
//
//     final productList = productListFromMap(jsonString);

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Client {
  Client({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory Client.fromMap(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );
}

