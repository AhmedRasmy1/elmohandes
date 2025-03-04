class AddProductEntity {
  final String? productName;
  final String? imageUrl;
  final String? countryOfOrigin;
  final num? price;
  final num? quantity;
  final num? discount;

  AddProductEntity({
    required this.productName,
    required this.imageUrl,
    required this.countryOfOrigin,
    required this.price,
    required this.quantity,
    required this.discount,
  });
}
