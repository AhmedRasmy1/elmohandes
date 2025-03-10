import 'package:elmohandes/features/home/domain/entities/add_bill_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_bill_model.g.dart';

@JsonSerializable()
class AddBillModel {
  String? id;
  String? customerName;
  String? customerPhone;
  String? payType;
  String? productName;
  num? price;
  num? discount;
  num? amount;
  num? totalPrice;
  String? createdByName;
  String? createdOn;

  AddBillModel(
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

  factory AddBillModel.fromJson(Map<String, dynamic> json) =>
      _$AddBillModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddBillModelToJson(this);

  AddBillEntity toAddBillEntity() {
    return AddBillEntity(
        customerName: customerName,
        customerPhone: customerPhone,
        payType: payType,
        productName: productName,
        price: price,
        discount: discount,
        amount: amount,
        totalPrice: totalPrice,
        createdByName: createdByName,
        createdOn: createdOn,
        billId: id);
  }
}
