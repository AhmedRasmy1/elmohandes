import '../../../../core/common/api_result.dart';
import '../entities/today_sales_info_entity.dart';
import '../repo/today_sales_info_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class TodaySalesInfoUseCase {
  TodaySalesInfoRepo todaySalesInfoRepo;

  TodaySalesInfoUseCase(this.todaySalesInfoRepo);

  Future<Result<TodaySalesInfoEntity>> getTotalSalesByDate(
          {required String token}) =>
      todaySalesInfoRepo.getTotalSalesByDate(token: token);
}
