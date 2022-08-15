// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
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
    required this.images,
    required this.reviews,
  });

  int id;
  int subCategoryId;
  String title;
  String subTitle;
  String search;
  String image;
  int rate;
  int rateCount;
  String description;
  double price;
  List<ProductImage> images;
  List<dynamic> reviews;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    search: json["search"],
    image: json["image"],
    rate: json["rate"],
    rateCount: json["rate_count"],
    description: json["description"],
    price: json["price"].toDouble(),
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
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
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
  };

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    subCategoryId: json["sub_category_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    search: json["search"],
    image: json["image"],
    rate: json["rate"],
    rateCount: json["rate_count"],
    description: json["description"],
    price: json["price"].toDouble(),
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromMap(x))),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
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
    "images": List<dynamic>.from(images.map((x) => x.toMap())),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
  };


}

class ProductImage {
  ProductImage({
    required this.id,
    required this.productId,
    required this.link,
  });

  int id;
  int productId;
  String link;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    productId: json["product_id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "link": link,
  };

  factory ProductImage.fromMap(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    productId: json["product_id"],
    link: json["link"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "link": link,
  };
}
