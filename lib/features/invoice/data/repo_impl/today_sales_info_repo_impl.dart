import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/data/data_sources/today_sales_info_data_sources.dart';
import 'package:elmohandes/features/invoice/domain/entities/today_sales_info_entity.dart';
import 'package:elmohandes/features/invoice/domain/repo/today_sales_info_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TodaySalesInfoRepo)
class TodaySalesInfoRepoImpl implements TodaySalesInfoRepo {
  TodaySalesInfoDataSources todaySalesInfoDataSources;

  TodaySalesInfoRepoImpl({required this.todaySalesInfoDataSources});
  @override
  Future<Result<TodaySalesInfoEntity>> getTotalSalesByDate(
      {required String token}) {
    return todaySalesInfoDataSources.getTotalSalesByDate(token: token);
  }
}
