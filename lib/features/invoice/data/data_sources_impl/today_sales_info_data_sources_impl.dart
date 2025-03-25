import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/data/data_sources/today_sales_info_data_sources.dart';
import 'package:elmohandes/features/invoice/domain/entities/today_sales_info_entity.dart';
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
