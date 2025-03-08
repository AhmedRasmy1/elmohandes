// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillsModel _$BillsModelFromJson(Map<String, dynamic> json) => BillsModel(
      id: json['id'] as String?,
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      payType: json['payType'] as String?,
      productName: json['productName'] as String?,
      price: (json['price'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      createdByName: json['createdByName'] as String?,
      createdOn: json['createdOn'] as String?,
    );

Map<String, dynamic> _$BillsModelToJson(BillsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'payType': instance.payType,
      'productName': instance.productName,
      'price': instance.price,
      'discount': instance.discount,
      'amount': instance.amount,
      'totalPrice': instance.totalPrice,
      'createdByName': instance.createdByName,
      'createdOn': instance.createdOn,
    };
