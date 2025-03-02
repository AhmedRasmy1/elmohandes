import 'package:elmohandes/features/home/domain/entities/products_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'products_model.g.dart';

@JsonSerializable()
class ProductsModel {
  int? id;
  String? name;
  String? imageUrl;
  String? countryOfOrigin;
  int? price;
  int? quantity;
  int? discount;
  String? createdAt;

  ProductsModel(
      {this.id,
      this.name,
      this.imageUrl,
      this.countryOfOrigin,
      this.price,
      this.quantity,
      this.discount,
      this.createdAt});

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);

  ProductsEntity toProductsEntity() {
    return ProductsEntity(
      productName: name,
      imageUrl: imageUrl,
      countryOfOrigin: countryOfOrigin,
      price: price,
      quantity: quantity,
      discount: discount,
    );
  }
}
