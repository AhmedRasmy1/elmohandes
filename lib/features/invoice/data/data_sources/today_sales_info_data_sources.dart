import '../../../../core/common/api_result.dart';
import '../../domain/entities/today_sales_info_entity.dart';

abstract class TodaySalesInfoDataSources {
  Future<Result<TodaySalesInfoEntity>> getTotalSalesByDate(
      {required String token});
}
