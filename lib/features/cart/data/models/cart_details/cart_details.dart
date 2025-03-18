import '../../../domain/entities/cart_details_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'cart_details.g.dart';

@JsonSerializable()
class CartDetails {
  int? id;
  Product? product;
  int? quantity;

  CartDetails({this.id, this.product, this.quantity});

  factory CartDetails.fromJson(Map<String, dynamic> json) {
    return _$CartDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartDetailsToJson(this);

  CartDetailsEntity toCartDetailsEntity() {
    return CartDetailsEntity(
      productName: product!.name,
      imageUrl: product!.imageUrl,
      price: product!.price,
      discount: product!.discount,
      quantity: quantity,
      productId: product!.id,
    );
  }
}
