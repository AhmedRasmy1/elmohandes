import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/total_sales_entity.dart';

abstract class TotalSalesDataSources {
  Future<Result<TotalSalesEntity>> getTotalSales(String token);
}
