// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductModel _$AddProductModelFromJson(Map<String, dynamic> json) =>
    AddProductModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      countryOfOrigin: json['countryOfOrigin'] as String?,
      price: json['price'] as num?,
      quantity: json['quantity'] as num?,
      discount: json['discount'] as num?,
    );

Map<String, dynamic> _$AddProductModelToJson(AddProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'countryOfOrigin': instance.countryOfOrigin,
      'price': instance.price,
      'quantity': instance.quantity,
      'discount': instance.discount,
    };
