class CartDetailsEntity {
  String? productName;
  String? imageUrl;
  num? price;
  num? quantity;
  num? discount;
  int? productId;

  CartDetailsEntity({
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.productId,
  });
}
