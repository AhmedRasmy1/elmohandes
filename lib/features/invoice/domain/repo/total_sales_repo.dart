import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/total_sales_entity.dart';

abstract class TotalSalesRepo {
  Future<Result<TotalSalesEntity>> getTotalSales(String token);
}
