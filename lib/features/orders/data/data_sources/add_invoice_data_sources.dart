import '../../../../core/common/api_result.dart';
import '../../domain/entities/add_invoice_entity.dart';

abstract class AddInvoiceDataSources {
  Future<Result<AddInvoiceEntity>> addInvoice(
      {required String token,
      required String customerName,
      required String customerPhone,
      required String payType});
}
