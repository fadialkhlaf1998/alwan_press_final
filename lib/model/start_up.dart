// To parse this JSON data, do
//
//     final startUp = startUpFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class StartUp {
  StartUp({
    required this.categories,
    required this.customerService,
    required this.banners,
    required this.suggestionSearch,
  });

  List<Category> categories;
  List<CustomerService> customerService;
  List<MyBanner> banners;
  List<SuggestionSearch> suggestionSearch;

  factory StartUp.fromJson(String str) => StartUp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartUp.fromMap(Map<String, dynamic> json) => StartUp(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
    customerService: List<CustomerService>.from(json["customer_service"].map((x) => CustomerService.fromMap(x))),
    banners: List<MyBanner>.from(json["banners"].map((x) => MyBanner.fromMap(x))),
    suggestionSearch: List<SuggestionSearch>.from(json["search_suggestion"].map((x) => SuggestionSearch.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
    "customer_service": List<dynamic>.from(customerService.map((x) => x.toMap())),
    "banners": List<dynamic>.from(banners.map((x) => x.toMap())),
    "search_suggestion": List<dynamic>.from(suggestionSearch.map((x) => x.toMap())),
  };
}

class MyBanner {
  MyBanner({
    required this.id,
    required this.productId,
    required this.image,
    required this.title,
  });

  int id;
  int productId;
  String image;
  String title;

  factory MyBanner.fromJson(String str) => MyBanner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyBanner.fromMap(Map<String, dynamic> json) => MyBanner(
    id: json["id"],
    productId: json["product_id"] ?? -1,
    image: json["image"] ?? "",
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId == null ? null : productId,
    "image": image,
    "title": title,
  };
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.color,
    required this.subCategories,
  });

  int id;
  String title;
  dynamic image;
  dynamic color;
  List<SubCategories> subCategories;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    image: json["image"] ?? "",
    color: json["color"] ?? "",
    subCategories: List<SubCategories>.from(json["sub_categories"].map((x) => SubCategories.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "image": image,
    "color": color,
    "sub_categories": List<dynamic>.from(subCategories.map((x) => x.toMap())),
  };

}

class CustomerService {
  CustomerService({
    required this.id,
    required this.language,
    required this.name,
    required this.image,
    required this.phone,
  });

  int id;
  String language;
  String name;
  String image;
  String phone;

  factory CustomerService.fromJson(String str) => CustomerService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerService.fromMap(Map<String, dynamic> json) => CustomerService(
    id: json["id"],
    language: json["language"],
    name: json["name"],
    image: json["image"],
    phone: json["phone"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "language": language,
    "name": name,
    "image": image,
    "phone": phone,
  };
}

class SubCategories{
 SubCategories({
 required this.id,
 required this.title,
 required this.image,
 required this.categoryId,
});

 late final int id;
 late final String title;
 late final String image;
 late final int categoryId;

 SubCategories.fromJson(Map<String, dynamic> json){
 id = json['id'];
 title = json['title'];
 image = json['image'];
 categoryId = json['category_id'];
 }
 Map<String, dynamic> toJson() {
   final _data = <String, dynamic>{};
   _data['id'] = id;
   _data['title'] = title;
   _data['image'] = image;
   _data['category_id'] = categoryId;
   return _data;
 }
 factory SubCategories.fromMap(Map<String, dynamic> json) => SubCategories(
   id: json["id"],
   title: json["title"] ?? "",
   image: json["image"],
   categoryId: json["category_id"],
 );

 Map<String, dynamic> toMap() => {
   "id": id,
   "title": title,
   "image": image,
   "category_id": categoryId,
 };
}


class SuggestionSearch {
  SuggestionSearch({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  int id;
  String title;
  String subTitle;
  String image;

  factory SuggestionSearch.fromJson(String str) => SuggestionSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuggestionSearch.fromMap(Map<String, dynamic> json) => SuggestionSearch(
    id: json["id"],
    title: json["title"]?? "",
    subTitle: json["sub_title"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "sub_title": subTitle,
    "image": image,
  };
}






// ----------------------------------


// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// class StartUp {
//   StartUp({
//     required this.categories,
//     required this.customerService,
//     required this.banners,
//     required this.suggestionSearch,
//   });
//   late final List<Category> categories;
//   late final List<CustomerService> customerService;
//   late final List<MyBanner> banners;
//   late final List<SuggestionSearch> suggestionSearch;
//
//   StartUp.fromJson(Map<String, dynamic> json){
//     categories = List.from(json['categories']).map((e)=>Category.fromJson(e)).toList();
//     customerService = List.from(json['customer_service']).map((e)=>CustomerService.fromJson(e)).toList();
//     banners = List.from(json['banners']).map((e)=>MyBanner.fromJson(e)).toList();
//     suggestionSearch = List.from(json['search_suggestion']).map((e)=>SuggestionSearch.fromJson(e)).toList();
//   }
//
//
//   Map<String, dynamic> toMap() => {
//     "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
//     "customer_service": List<dynamic>.from(customerService.map((x) => x.toMap())),
//     "banners": List<dynamic>.from(banners.map((x) => x.toMap())),
//     "search_suggestion": List<dynamic>.from(suggestionSearch.map((x) => x.toMap())),
//   };
// }
//    factory StartUp.fromJson(String str) => StartUp.fromMap(json.decode(str));
//
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['categories'] = categories.map((e)=>e.toJson()).toList();
//     _data['customer_service'] = customerService.map((e)=>e.toJson()).toList();
//     _data['banners'] = banners.map((e)=>e.toJson()).toList();
//     _data['search_suggestion'] = suggestionSearch.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class Category {
//   Category({
//     required this.id,
//     required this.title,
//     required this.subCategories,
//
//   });
//   late final int id;
//   late final String title;
//   late final String image;
//   late final List<SubCategories> subCategories;
//
//   Category.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     title = json['title'];
//     image = json['image'] ?? "";
//     subCategories = List.from(json['sub_categories']).map((e)=>SubCategories.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['title'] = title;
//     _data['image'] = image;
//     _data['sub_categories'] = subCategories.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class SubCategories{
//  SubCategories({
//  required this.id,
//  required this.title,
//  required this.image,
//  required this.categoryId,
// });
//
//  late final int id;
//  late final String title;
//  late final String image;
//  late final int categoryId;
//
//  SubCategories.fromJson(Map<String, dynamic> json){
//  id = json['id'];
//  title = json['title'];
//  image = json['image'];
//  categoryId = json['category_id'];
//  }
//  Map<String, dynamic> toJson() {
//    final _data = <String, dynamic>{};
//    _data['id'] = id;
//    _data['title'] = title;
//    _data['image'] = image;
//    _data['category_id'] = categoryId;
//    return _data;
//  }
// }
// class CustomerService {
//   CustomerService({
//     required this.id,
//     required this.language,
//     required this.name,
//     required this.image,
//     required this.phone,
//   });
//
//   int id;
//   String language;
//   String name;
//   String image;
//   String phone;
//
//   factory CustomerService.fromJson(String str) => CustomerService.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory CustomerService.fromMap(Map<String, dynamic> json) => CustomerService(
//     id: json["id"],
//     language: json["language"],
//     name: json["name"],
//     image: json["image"],
//     phone: json["phone"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "language": language,
//     "name": name,
//     "image": image,
//     "phone": phone,
//   };
// }
//
// class MyBanner {
//   MyBanner({
//     required this.id,
//     required this.productId,
//     required this.image,
//     required this.title,
//   });
//
//   int id;
//   int productId;
//   String image;
//   String title;
//
//   factory MyBanner.fromJson(String str) => MyBanner.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory MyBanner.fromMap(Map<String, dynamic> json) => MyBanner(
//     id: json["id"],
//     productId: json["product_id"] ?? -1,
//     image: json["image"],
//     title: json["title"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "product_id": productId == null ? null : productId,
//     "image": image,
//     "title": title,
//   };
// }
//
// class SuggestionSearch {
//   SuggestionSearch({
//     required this.id,
//     required this.title,
//     required this.subTitle,
//     required this.image,
//   });
//
//   int id;
//   String title;
//   String subTitle;
//   String image;
//
//   factory SuggestionSearch.fromJson(String str) => SuggestionSearch.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory SuggestionSearch.fromMap(Map<String, dynamic> json) => SuggestionSearch(
//     id: json["id"],
//     title: json["title"]?? "",
//     subTitle: json["sub_title"] ?? "",
//     image: json["image"] ?? "",
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "title": title,
//     "sub_title": subTitle,
//     "image": image,
//   };
// }