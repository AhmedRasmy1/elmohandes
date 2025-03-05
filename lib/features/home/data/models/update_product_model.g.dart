// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProduct _$UpdateProductFromJson(Map<String, dynamic> json) =>
    UpdateProduct(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      countryOfOrigin: json['countryOfOrigin'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateProductToJson(UpdateProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'countryOfOrigin': instance.countryOfOrigin,
      'price': instance.price,
      'quantity': instance.quantity,
      'discount': instance.discount,
    };
