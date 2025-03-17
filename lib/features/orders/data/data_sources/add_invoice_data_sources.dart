import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/orders/domain/entities/add_invoice_entity.dart';

abstract class AddInvoiceDataSources {
  Future<Result<AddInvoiceEntity>> addInvoice(
      {required String token,
      required String customerName,
      required String customerPhone,
      required String payType});
}
