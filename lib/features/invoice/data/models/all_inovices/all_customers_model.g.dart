// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_customers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCustomerModel _$AllCustomerModelFromJson(Map<String, dynamic> json) =>
    AllCustomerModel(
      custName: json['custName'] as String?,
      custPhone: json['custPhone'] as String?,
      totalRemaining: (json['totalRemaining'] as num?)?.toInt(),
      totalPaid: (json['totalPaid'] as num?)?.toInt(),
      totalAmount: (json['totalAmount'] as num?)?.toInt(),
      flag: json['flag'] as bool?,
    );

Map<String, dynamic> _$AllCustomerModelToJson(AllCustomerModel instance) =>
    <String, dynamic>{
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'totalRemaining': instance.totalRemaining,
      'totalPaid': instance.totalPaid,
      'totalAmount': instance.totalAmount,
      'flag': instance.flag,
    };
