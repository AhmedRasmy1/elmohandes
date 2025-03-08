import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/bills_entity.dart';
import 'package:elmohandes/features/home/domain/reposatory/bills_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class BillsUseCase {
  final BillsRepo billsRepo;
  BillsUseCase(this.billsRepo);

  Future<Result<List<BillsEntity>>> getAllBills(String token) {
    return billsRepo.getAllBills(token);
  }
}
