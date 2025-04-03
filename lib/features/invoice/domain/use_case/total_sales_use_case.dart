import '../../../../core/common/api_result.dart';
import '../entities/total_sales_entity.dart';
import '../repo/total_sales_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class TotalSalesUseCase {
  TotalSalesRepo totalSalesRepo;
  TotalSalesUseCase(this.totalSalesRepo);

  Future<Result<TotalSalesEntity>> getTotalSales(String token) {
    return totalSalesRepo.getTotalSales(token);
  }
}
