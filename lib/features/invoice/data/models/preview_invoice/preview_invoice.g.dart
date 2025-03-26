// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewInvoice _$PreviewInvoiceFromJson(Map<String, dynamic> json) =>
    PreviewInvoice(
      invoiceNumber: json['invoiceNumber'] as String?,
      userId: json['userId'] as String?,
      invoiceItems: (json['invoiceItems'] as List<dynamic>?)
          ?.map((e) => InvoiceItemPreview.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PreviewInvoiceToJson(PreviewInvoice instance) =>
    <String, dynamic>{
      'invoiceNumber': instance.invoiceNumber,
      'userId': instance.userId,
      'invoiceItems': instance.invoiceItems,
      'totalAmount': instance.totalAmount,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
