import '../repo/delete_all_invoices_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAllInvoicesUseCase {
  DeleteAllInvoicesRepo deleteAllInvoicesRepo;
  DeleteAllInvoicesUseCase({required this.deleteAllInvoicesRepo});
  Future deleteAllInvoices({required String token}) {
    return deleteAllInvoicesRepo.deleteAllInvoices(token: token);
  }
}
