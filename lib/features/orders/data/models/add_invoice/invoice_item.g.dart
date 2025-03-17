// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) => InvoiceItem(
      id: (json['id'] as num?)?.toInt(),
      invoiceId: (json['invoiceId'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InvoiceItemToJson(InvoiceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceId': instance.invoiceId,
      'productId': instance.productId,
      'product': instance.product,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
    };
