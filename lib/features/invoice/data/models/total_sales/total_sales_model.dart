import 'package:elmohandes/features/invoice/domain/entities/total_sales_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'total_sales_model.g.dart';

@JsonSerializable()
class TotalSalesModel {
  double? totalSales;
  TotalSalesModel({
    this.totalSales,
  });

  factory TotalSalesModel.fromJson(Map<String, dynamic> json) =>
      _$TotalSalesModelFromJson(json);
  Map<String, dynamic> toJson() => _$TotalSalesModelToJson(this);

  TotalSalesEntity toTotalSalesEntity() {
    return TotalSalesEntity(
      totalSales: totalSales,
    );
  }
}
