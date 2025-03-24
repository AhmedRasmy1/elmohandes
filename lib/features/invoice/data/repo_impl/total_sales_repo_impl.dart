import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/data/data_sources/total_sales_data_sources.dart';
import 'package:elmohandes/features/invoice/domain/entities/total_sales_entity.dart';
import 'package:elmohandes/features/invoice/domain/repo/total_sales_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TotalSalesRepo)
class TotalSalesRepoImpl implements TotalSalesRepo {
  TotalSalesDataSources totalSalesDataSources;
  TotalSalesRepoImpl(this.totalSalesDataSources);
  @override
  Future<Result<TotalSalesEntity>> getTotalSales(String token) {
    return totalSalesDataSources.getTotalSales(token);
  }
}
