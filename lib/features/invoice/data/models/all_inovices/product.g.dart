// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      countryOfOrigin: json['countryOfOrigin'] as String?,
      price: (json['price'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countryOfOrigin': instance.countryOfOrigin,
      'price': instance.price,
      'discount': instance.discount,
      'imageUrl': instance.imageUrl,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
