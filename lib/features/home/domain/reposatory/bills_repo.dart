import '../../../../core/common/api_result.dart';
import '../entities/bills_entity.dart';

abstract class BillsRepo {
  Future<Result<List<BillsEntity>>> getAllBills(String token);
}
