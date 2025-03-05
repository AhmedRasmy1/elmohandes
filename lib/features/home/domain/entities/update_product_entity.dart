class UpdateProductEntity {
  final int? id;
  final String? name;
  final String? countryOfOrigin;
  final num? quantity;
  final num? price;
  final num? discount;

  UpdateProductEntity(
      {required this.id,
      required this.name,
      required this.countryOfOrigin,
      required this.quantity,
      required this.price,
      required this.discount});
}
