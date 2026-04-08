import 'package:elmohandes/features/invoice/domain/entities/all_customers_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'all_customers_model.g.dart';

@JsonSerializable()
class AllCustomerModel {
  String? custName;
  String? custPhone;
  int? totalRemaining;
  int? totalPaid;
  int? totalAmount;
  bool? flag;

  AllCustomerModel(
      {this.custName,
      this.custPhone,
      this.totalRemaining,
      this.totalPaid,
      this.totalAmount,
      this.flag});

  factory AllCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$AllCustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$AllCustomerModelToJson(this);

  AllCustomersEntity toAllCustomersEntity() {
    return AllCustomersEntity(
      custName: custName,
      custPhone: custPhone,
      totalPaid: totalPaid,
      totalAmount: totalAmount,
      flag: flag,
    );
  }
}
