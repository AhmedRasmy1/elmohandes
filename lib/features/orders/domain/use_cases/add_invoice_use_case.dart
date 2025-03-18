import '../../../../core/common/api_result.dart';
import '../entities/add_invoice_entity.dart';
import '../repo/add_invoice_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddInvoiceUseCase {
  AddInvoiceRepo addInvoiceRepo;
  AddInvoiceUseCase(this.addInvoiceRepo);
  Future<Result<AddInvoiceEntity>> addInvoice(
      {required String token,
      required String customerName,
      required String customerPhone,
      required String payType}) {
    return addInvoiceRepo.addInvoice(
        token: token,
        customerName: customerName,
        customerPhone: customerPhone,
        payType: payType);
  }
}
