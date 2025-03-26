import 'package:json_annotation/json_annotation.dart';

part 'invoice_item_preview.g.dart';

@JsonSerializable()
class InvoiceItemPreview {
  int? productId;
  String? productName;
  String? countryOfOrigin;
  int? quantity;
  int? discount;
  int? unitPrice;
  double? totalPrice;

  InvoiceItemPreview({
    this.productId,
    this.productName,
    this.countryOfOrigin,
    this.quantity,
    this.discount,
    this.unitPrice,
    this.totalPrice,
  });

  factory InvoiceItemPreview.fromJson(Map<String, dynamic> json) {
    return _$InvoiceItemPreviewFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvoiceItemPreviewToJson(this);
}
