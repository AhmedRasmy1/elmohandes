import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/today_sales_info_data_sources.dart';
import '../../domain/entities/today_sales_info_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TodaySalesInfoDataSources)
class TodaySalesInfoDataSourcesImpl implements TodaySalesInfoDataSources {
  ApiService apiService;
  TodaySalesInfoDataSourcesImpl(this.apiService);
  @override
  Future<Result<TodaySalesInfoEntity>> getTotalSalesByDate(
      {required String token}) {
    return executeApi(() async {
      var response = await apiService.getTotalSalesByDate(token);
      var data = response.todaySalesInfoEntity();
      return data;
    });
  }
}
