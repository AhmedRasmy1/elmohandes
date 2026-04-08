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

//--------------------------------------------------------------
@injectable
class PayFullUseCase {
  PayFullRepo payFullRepo;
  PayFullUseCase({required this.payFullRepo});
  Future payFull({required String id, required String token}) {
    return payFullRepo.payFull(id: id, token: token);
  }
}

//--------------------------------------------------------------
@injectable
class PayPartialUseCase {
  PayPartialRepo payPartialRepo;
  PayPartialUseCase({required this.payPartialRepo});
  Future payPartial(
      {required String id, required String token, required double amount}) {
    return payPartialRepo.payPartial(id: id, token: token, amount: amount);
  }
}
