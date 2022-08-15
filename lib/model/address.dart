// To parse this JSON data, do
//
//     final address = addressFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Address {
  Address({
    required this.nickName,
    required this.streetName,
    required this.building,
    required this.floor,
    required this.flat,
    required this.adDesc,
    required this.phone,
  });

  String nickName;
  String streetName;
  String building;
  String floor;
  String flat;
  String adDesc;
  String phone;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    nickName: json["nick_name"],
    streetName: json["street_name"],
    building: json["building"],
    floor: json["floor"],
    flat: json["flat"],
    adDesc: json["ad_desc"],
    phone: json["phone"],
  );

  Map<String, dynamic> toMap() => {
    "nick_name": nickName,
    "street_name": streetName,
    "building": building,
    "floor": floor,
    "flat": flat,
    "ad_desc": adDesc,
    "phone": phone,
  };
}
