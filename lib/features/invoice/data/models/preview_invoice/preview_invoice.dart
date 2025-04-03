import '../../../domain/entities/preview_invoice_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'invoice_item_preview.dart';

part 'preview_invoice.g.dart';

@JsonSerializable()
class PreviewInvoice {
  String? invoiceNumber;
  String? userId;
  List<InvoiceItemPreview>? invoiceItems;
  double? totalAmount;
  DateTime? createdAt;

  PreviewInvoice({
    this.invoiceNumber,
    this.userId,
    this.invoiceItems,
    this.totalAmount,
    this.createdAt,
  });

  factory PreviewInvoice.fromJson(Map<String, dynamic> json) {
    return _$PreviewInvoiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PreviewInvoiceToJson(this);

  PreviewInvoiceEntity toPreviewInvoiceEntity() {
    return PreviewInvoiceEntity(
      invoiceNumber: invoiceNumber,
      totalAmount: totalAmount,
      invoiceItems: invoiceItems,
      createdAt: createdAt,
    );
  }
}
