import '../reposatory/delete_all_bills.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAllBillsUseCase {
  final DeleteAllBillsRepo deleteAllBillsRepo;

  DeleteAllBillsUseCase(this.deleteAllBillsRepo);

  Future deleteAllBills(String token) {
    return deleteAllBillsRepo.deleteAllBills(token);
  }
}
