import '../../../../core/common/api_result.dart';
import '../../domain/entities/total_sales_entity.dart';

abstract class TotalSalesDataSources {
  Future<Result<TotalSalesEntity>> getTotalSales(String token);
}
