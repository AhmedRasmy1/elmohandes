// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItemPreview _$InvoiceItemPreviewFromJson(Map<String, dynamic> json) =>
    InvoiceItemPreview(
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      countryOfOrigin: json['countryOfOrigin'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$InvoiceItemPreviewToJson(InvoiceItemPreview instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'countryOfOrigin': instance.countryOfOrigin,
      'quantity': instance.quantity,
      'discount': instance.discount,
      'unitPrice': instance.unitPrice,
      'totalPrice': instance.totalPrice,
    };
