import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/today_sales_info_entity.dart';

abstract class TodaySalesInfoDataSources {
  Future<Result<TodaySalesInfoEntity>> getTotalSalesByDate(
      {required String token});
}
