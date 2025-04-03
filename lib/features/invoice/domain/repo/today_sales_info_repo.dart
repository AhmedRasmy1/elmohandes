import '../../../../core/common/api_result.dart';
import '../entities/today_sales_info_entity.dart';

abstract class TodaySalesInfoRepo {
  Future<Result<TodaySalesInfoEntity>> getTotalSalesByDate(
      {required String token});
}
