import 'package:elmohandes/features/home/domain/entities/update_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_product_model.g.dart';

@JsonSerializable()
class UpdateProduct {
  int? id;
  String? name;
  String? imageUrl;
  String? countryOfOrigin;
  int? price;
  int? quantity;
  int? discount;

  UpdateProduct(
      {this.id,
      this.name,
      this.imageUrl,
      this.countryOfOrigin,
      this.price,
      this.quantity,
      this.discount});

  factory UpdateProduct.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductToJson(this);

  UpdateProductEntity toUpdateProductEntity() {
    return UpdateProductEntity(
      name: name,
      countryOfOrigin: countryOfOrigin,
      quantity: quantity,
      price: price,
      discount: discount,
      id: id,
    );
  }
}
