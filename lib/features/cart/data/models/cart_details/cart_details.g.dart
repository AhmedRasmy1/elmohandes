// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDetails _$CartDetailsFromJson(Map<String, dynamic> json) => CartDetails(
      id: (json['id'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartDetailsToJson(CartDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'quantity': instance.quantity,
    };
