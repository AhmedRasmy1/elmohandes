import '../../../../core/common/api_result.dart';
import '../../domain/entities/bills_entity.dart';

abstract class BillsDataSources {
  Future<Result<List<BillsEntity>>> getAllBills(String token);
}
