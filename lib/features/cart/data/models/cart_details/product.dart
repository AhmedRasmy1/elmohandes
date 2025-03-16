import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? name;
  String? countryOfOrigin;
  int? price;
  int? discount;
  String? imageUrl;
  int? quantity;
  DateTime? createdAt;

  Product({
    this.id,
    this.name,
    this.countryOfOrigin,
    this.price,
    this.discount,
    this.imageUrl,
    this.quantity,
    this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
