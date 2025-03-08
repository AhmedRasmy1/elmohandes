import 'package:elmohandes/features/home/domain/entities/bills_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bills_model.g.dart';

@JsonSerializable()
class BillsModel {
  String? id;
  String? customerName;
  String? customerPhone;
  String? payType;
  String? productName;
  int? price;
  int? discount;
  int? amount;
  int? totalPrice;
  String? createdByName;
  String? createdOn;

  BillsModel(
      {this.id,
      this.customerName,
      this.customerPhone,
      this.payType,
      this.productName,
      this.price,
      this.discount,
      this.amount,
      this.totalPrice,
      this.createdByName,
      this.createdOn});

  factory BillsModel.fromJson(Map<String, dynamic> json) =>
      _$BillsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillsModelToJson(this);

  BillsEntity toBillsEntity() {
    return BillsEntity(
      id: id!,
      customerName: customerName!,
      customerPhone: customerPhone!,
      payType: payType!,
      productName: productName!,
      price: price!,
      discount: discount!,
      amount: amount!,
      totalPrice: totalPrice!,
      createdByName: createdByName!,
      createdAt: createdOn!,
    );
  }
}
