import '../../data/models/all_inovices/invoice_item.dart';

class AllInvoiceEntity {
  final String? customerName;
  final String? customerPhone;
  final String? payType;
  final String? casherName;
  final List<InvoiceItem>? invoiceItems;
  final String? createdAt;
  final num? invoiceTotalPrice;
  final String? invoiceNumber;

  AllInvoiceEntity({
    required this.customerName,
    required this.customerPhone,
    required this.payType,
    required this.casherName,
    required this.invoiceItems,
    required this.createdAt,
    required this.invoiceTotalPrice,
    required this.invoiceNumber,
  });
}
