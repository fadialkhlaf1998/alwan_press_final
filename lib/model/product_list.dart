// To parse this JSON data, do
//
//     final productList = productListFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ProductList> productListFromMap(String str) => List<ProductList>.from(json.decode(str).map((x) => ProductList.fromMap(x)));

String productListToMap(List<ProductList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProductList {
  ProductList({
    required this.id,
    required this.subCategoryId,
    required this.title,
    required this.subTitle,
    required this.search,
    required this.image,
    required this.rate,
    required this.rateCount,
    required this.description,
    required this.price,
    required this.ar_title,
    required this.ar_desc,
  });

  int id;
  int subCategoryId;
  String title;
  String ar_title;
  String subTitle;
  String search;
  String image;
  int rate;
  int rateCount;
  String description;
  String ar_desc;
  double price;

  factory ProductList.fromMap(Map<String, dynamic> json) => ProductList(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    title: json["title"],
    ar_desc: json["ar_desc"],
    ar_title: json["ar_title"],
    subTitle: json["sub_title"],
    search: json["search"],
    image: json["image"],
    rate: json["rate"],
    rateCount: json["rate_count"],
    description: json["description"],
    price: json["price"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "title": title,
    "sub_title": subTitle,
    "search": search,
    "image": image,
    "rate": rate,
    "rate_count": rateCount,
    "description": description,
    "price": price,
  };
  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    search: json["search"],
    image: json["image"],
    rate: json["rate"],
    ar_desc: json["ar_desc"],
    ar_title: json["ar_title"],
    rateCount: json["rate_count"],
    description: json["description"],
    price: json["price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_category_id": subCategoryId,
    "title": title,
    "sub_title": subTitle,
    "search": search,
    "image": image,
    "rate": rate,
    "rate_count": rateCount,
    "description": description,
    "price": price,
  };

}
