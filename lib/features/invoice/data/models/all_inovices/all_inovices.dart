import '../../../domain/entities/all_invoices_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'invoice_item.dart';

part 'all_inovices.g.dart';

@JsonSerializable()
class AllInovices {
  int? id;
  String? invoiceNumber;
  String? userId;
  dynamic user;
  String? customerName;
  String? customerPhone;
  String? payType;
  String? caisherName;
  List<InvoiceItem>? invoiceItems;
  DateTime? createdAt;
  int? totalAmount;
  double? paidAmount;
  double? remainingAmount;

  AllInovices({
    this.id,
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
    this.remainingAmount,
  });

  factory AllInovices.fromJson(Map<String, dynamic> json) {
    return _$AllInovicesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllInovicesToJson(this);

  AllInvoiceEntity toAllInvoiceEntity() {
    return AllInvoiceEntity(
      invoiceNumber: invoiceNumber,
      customerName: customerName,
      customerPhone: customerPhone,
      payType: payType,
      casherName: caisherName,
      invoiceItems: invoiceItems,
      createdAt: createdAt.toString(),
      invoiceTotalPrice: totalAmount,
      paidAmount: paidAmount,
      remainingAmount: remainingAmount,
    );
  }
}
