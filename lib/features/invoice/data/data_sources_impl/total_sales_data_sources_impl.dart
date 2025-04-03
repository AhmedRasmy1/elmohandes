import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/total_sales_data_sources.dart';
import '../../domain/entities/total_sales_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TotalSalesDataSources)
class TotalSalesDataSourcesImpl implements TotalSalesDataSources {
  ApiService apiService;

  TotalSalesDataSourcesImpl(this.apiService);
  @override
  Future<Result<TotalSalesEntity>> getTotalSales(String token) {
    return executeApi(() async {
      var response = await apiService.getTotalSales(token);
      var data = response.toTotalSalesEntity();
      return data;
    });
  }
}
