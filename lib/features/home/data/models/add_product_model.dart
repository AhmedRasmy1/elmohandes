import '../../domain/entities/add_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_product_model.g.dart';

@JsonSerializable()
class AddProductModel {
  int? id;
  String? name;
  String? imageUrl;
  String? countryOfOrigin;
  num? price;
  num? quantity;
  num? discount;

  AddProductModel({
    this.id,
    this.name,
    this.imageUrl,
    this.countryOfOrigin,
    this.price,
    this.quantity,
    this.discount,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) =>
      _$AddProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductModelToJson(this);

  AddProductEntity toAddProductEntity() {
    return AddProductEntity(
      productName: name,
      imageUrl: imageUrl,
      countryOfOrigin: countryOfOrigin,
      price: price,
      quantity: quantity,
      discount: discount,
    );
  }
}
