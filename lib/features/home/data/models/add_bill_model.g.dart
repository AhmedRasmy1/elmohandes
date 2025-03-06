// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBillModel _$AddBillModelFromJson(Map<String, dynamic> json) => AddBillModel(
      id: json['id'] as String?,
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      payType: json['payType'] as String?,
      productName: json['productName'] as String?,
      price: json['price'] as num?,
      discount: json['discount'] as num?,
      amount: json['amount'] as num?,
      totalPrice: json['totalPrice'] as num?,
      createdByName: json['createdByName'] as String?,
      createdOn: json['createdOn'] as String?,
    );

Map<String, dynamic> _$AddBillModelToJson(AddBillModel instance) =>
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
