import 'package:elmohandes/features/invoice/data/models/preview_invoice/invoice_item_preview.dart';

class PreviewInvoiceEntity {
  final String? invoiceNumber;
  final List<InvoiceItemPreview>? invoiceItems;
  final num? totalAmount;
  final DateTime? createdAt;

  PreviewInvoiceEntity({
    required this.invoiceNumber,
    required this.invoiceItems,
    required this.totalAmount,
    required this.createdAt,
  });
}
