// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_inovices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllInovices _$AllInovicesFromJson(Map<String, dynamic> json) => AllInovices(
      id: (json['id'] as num?)?.toInt(),
      invoiceNumber: json['invoiceNumber'] as String?,
      userId: json['userId'] as String?,
      user: json['user'],
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      payType: json['payType'] as String?,
      caisherName: json['caisherName'] as String?,
      invoiceItems: (json['invoiceItems'] as List<dynamic>?)
          ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      totalAmount: (json['totalAmount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AllInovicesToJson(AllInovices instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceNumber': instance.invoiceNumber,
      'userId': instance.userId,
      'user': instance.user,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'payType': instance.payType,
      'caisherName': instance.caisherName,
      'invoiceItems': instance.invoiceItems,
      'createdAt': instance.createdAt?.toIso8601String(),
      'totalAmount': instance.totalAmount,
    };
