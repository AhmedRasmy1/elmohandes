import '../../../domain/entities/today_sales_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'today_sales_info_model.g.dart';

@JsonSerializable()
class TodaySalesInfoModel {
  num? invoiceCount;
  num? totalSales;
  TodaySalesInfoModel({
    this.invoiceCount,
    this.totalSales,
  });

  TodaySalesInfoEntity todaySalesInfoEntity() {
    return TodaySalesInfoEntity(
      invoiceCount: invoiceCount,
      totalSales: totalSales,
    );
  }

  factory TodaySalesInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TodaySalesInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodaySalesInfoModelToJson(this);
}
