import '../../../domain/entities/add_invoice_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'invoice_item.dart';

part 'add_invoice.g.dart';

@JsonSerializable()
class AddInvoice {
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

  AddInvoice({
    this.id,
    this.userId,
    this.user,
    this.customerName,
    this.customerPhone,
    this.payType,
    this.caisherName,
    this.invoiceItems,
    this.createdAt,
    this.totalAmount,
    this.invoiceNumber,
  });

  factory AddInvoice.fromJson(Map<String, dynamic> json) {
    return _$AddInvoiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddInvoiceToJson(this);

  AddInvoiceEntity toAddInvoiceEntity() {
    return AddInvoiceEntity(
      id: id,
      customerName: customerName,
      customerPhone: customerPhone,
      payType: payType,
      casherName: caisherName,
      invoiceItems: invoiceItems,
      createdAt: createdAt.toString(),
      invoiceTotalPrice: totalAmount,
      invoiceNumber: invoiceNumber,
    );
  }
}
