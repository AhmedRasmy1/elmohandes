import 'package:elmohandes/features/invoice/domain/entities/customer_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable()
class CustomerModel {
  String? custName;
  String? custPhone;
  int? totalRemaining;
  int? totalPaid;
  int? totalAmount;
  List<Invoices>? invoices;

  CustomerModel({
    this.custName,
    this.custPhone,
    this.totalRemaining,
    this.totalPaid,
    this.totalAmount,
    this.invoices,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  CustomerEntity toCustomerEntity() {
    return CustomerEntity(
      name: custName ?? '',
      phone: custPhone ?? '',
      totalPaid: totalPaid?.toDouble() ?? 0.0,
      totalAmount: totalAmount?.toDouble() ?? 0.0,
      totalRemaining: totalRemaining?.toDouble() ?? 0.0,
      invoices: invoices ?? [],
    );
  }
}

@JsonSerializable()
class Invoices {
  int? id;
  String? invoiceNumber;
  String? userId;
  dynamic user;
  String? customerName;
  String? customerPhone;
  String? payType;
  String? caisherName;
  List<InvoiceItems>? invoiceItems;
  String? createdAt;
  int? totalAmount;
  int? paidAmount;
  int? remainingAmount;

  Invoices(
      {this.id,
      this.invoiceNumber,
      this.userId,
      this.user,
      this.customerName,
      this.customerPhone,
      this.payType,
      this.caisherName,
      this.invoiceItems,
      this.createdAt,
      this.totalAmount,
      this.paidAmount,
      this.remainingAmount});

  factory Invoices.fromJson(Map<String, dynamic> json) {
    return _$InvoicesFromJson(json);
  }
  Map<String, dynamic> toJson() => _$InvoicesToJson(this);
}

@JsonSerializable()
class InvoiceItems {
  int? id;
  int? invoiceId;
  int? productId;
  Product? product;
  int? quantity;
  int? totalPrice;

  InvoiceItems(
      {this.id,
      this.invoiceId,
      this.productId,
      this.product,
      this.quantity,
      this.totalPrice});
  factory InvoiceItems.fromJson(Map<String, dynamic> json) {
    return _$InvoiceItemsFromJson(json);
  }
  Map<String, dynamic> toJson() => _$InvoiceItemsToJson(this);
}

@JsonSerializable()
class Product {
  int? id;
  String? name;
  String? countryOfOrigin;
  int? price;
  int? discount;
  String? imageUrl;
  int? quantity;
  String? createdAt;

  Product(
      {this.id,
      this.name,
      this.countryOfOrigin,
      this.price,
      this.discount,
      this.imageUrl,
      this.quantity,
      this.createdAt});
  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
