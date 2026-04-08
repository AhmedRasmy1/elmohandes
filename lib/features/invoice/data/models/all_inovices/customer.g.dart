// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      custName: json['custName'] as String?,
      custPhone: json['custPhone'] as String?,
      totalRemaining: (json['totalRemaining'] as num?)?.toInt(),
      totalPaid: (json['totalPaid'] as num?)?.toInt(),
      totalAmount: (json['totalAmount'] as num?)?.toInt(),
      invoices: (json['invoices'] as List<dynamic>?)
          ?.map((e) => Invoices.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'totalRemaining': instance.totalRemaining,
      'totalPaid': instance.totalPaid,
      'totalAmount': instance.totalAmount,
      'invoices': instance.invoices,
    };

Invoices _$InvoicesFromJson(Map<String, dynamic> json) => Invoices(
      id: (json['id'] as num?)?.toInt(),
      invoiceNumber: json['invoiceNumber'] as String?,
      userId: json['userId'] as String?,
      user: json['user'],
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      payType: json['payType'] as String?,
      caisherName: json['caisherName'] as String?,
      invoiceItems: (json['invoiceItems'] as List<dynamic>?)
          ?.map((e) => InvoiceItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toInt(),
      paidAmount: (json['paidAmount'] as num?)?.toInt(),
      remainingAmount: (json['remainingAmount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InvoicesToJson(Invoices instance) => <String, dynamic>{
      'id': instance.id,
      'invoiceNumber': instance.invoiceNumber,
      'userId': instance.userId,
      'user': instance.user,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'payType': instance.payType,
      'caisherName': instance.caisherName,
      'invoiceItems': instance.invoiceItems,
      'createdAt': instance.createdAt,
      'totalAmount': instance.totalAmount,
      'paidAmount': instance.paidAmount,
      'remainingAmount': instance.remainingAmount,
    };

InvoiceItems _$InvoiceItemsFromJson(Map<String, dynamic> json) => InvoiceItems(
      id: (json['id'] as num?)?.toInt(),
      invoiceId: (json['invoiceId'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InvoiceItemsToJson(InvoiceItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceId': instance.invoiceId,
      'productId': instance.productId,
      'product': instance.product,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      countryOfOrigin: json['countryOfOrigin'] as String?,
      price: (json['price'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countryOfOrigin': instance.countryOfOrigin,
      'price': instance.price,
      'discount': instance.discount,
      'imageUrl': instance.imageUrl,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt,
    };
