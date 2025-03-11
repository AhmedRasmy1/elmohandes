import '../../../../core/common/api_result.dart';
import '../entities/bills_entity.dart';
import '../reposatory/bills_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class BillsUseCase {
  final BillsRepo billsRepo;
  BillsUseCase(this.billsRepo);

  Future<Result<List<BillsEntity>>> getAllBills(String token) {
    return billsRepo.getAllBills(token);
  }
}
