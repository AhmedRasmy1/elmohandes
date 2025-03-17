import 'package:elmohandes/features/orders/data/models/add_invoice/invoice_item.dart';

class AddInvoiceEntity {
  final int? id;
  final String? customerName;
  final String? customerPhone;
  final String? payType;
  final String? casherName;
  final List<InvoiceItem>? invoiceItems;
  final String? createdAt;
  final num? invoiceTotalPrice;
  final String? invoiceNumber;

  AddInvoiceEntity(
      {required this.id,
      required this.customerName,
      required this.customerPhone,
      required this.payType,
      required this.casherName,
      required this.invoiceItems,
      required this.createdAt,
      required this.invoiceTotalPrice,
      required this.invoiceNumber});
}
