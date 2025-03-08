class BillsEntity {
  final String? id;
  final String? customerName;
  final String? customerPhone;
  final String? payType;
  final String? productName;
  final num? price;
  final num? discount;
  final num? amount;
  final num? totalPrice;
  final String? createdByName;
  final String? createdAt;

  BillsEntity(
      {required this.id,
      required this.customerName,
      required this.customerPhone,
      required this.payType,
      required this.productName,
      required this.price,
      required this.discount,
      required this.amount,
      required this.totalPrice,
      required this.createdByName,
      required this.createdAt});
}
