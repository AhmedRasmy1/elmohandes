import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'invoice_item.g.dart';

@JsonSerializable()
class InvoiceItem {
  int? id;
  int? invoiceId;
  int? productId;
  Product? product;
  int? quantity;
  int? totalPrice;

  InvoiceItem({
    this.id,
    this.invoiceId,
    this.productId,
    this.product,
    this.quantity,
    this.totalPrice,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return _$InvoiceItemFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvoiceItemToJson(this);
}
