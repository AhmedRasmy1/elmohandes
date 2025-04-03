import '../../../../core/common/api_result.dart';
import '../entities/total_sales_entity.dart';

abstract class TotalSalesRepo {
  Future<Result<TotalSalesEntity>> getTotalSales(String token);
}
