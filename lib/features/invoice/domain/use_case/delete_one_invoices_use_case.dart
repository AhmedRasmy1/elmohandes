import '../repo/delete_one_invoice_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteOneInvoicesUseCase {
  DeleteOneInvoiceRepo deleteOneInvoiceRepo;
  DeleteOneInvoicesUseCase({required this.deleteOneInvoiceRepo});
  Future deleteOneInvoice({required String id, required String token}) {
    return deleteOneInvoiceRepo.deleteOneInvoice(id: id, token: token);
  }
}
