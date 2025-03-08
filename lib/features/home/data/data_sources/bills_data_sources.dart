import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/bills_entity.dart';

abstract class BillsDataSources {
  Future<Result<List<BillsEntity>>> getAllBills(String token);
}
