import '../../../../core/common/api_result.dart';
import '../entities/preview_invoice_entity.dart';

abstract class PreviewInvoiceRepo {
  Future<Result<PreviewInvoiceEntity>> getInvoicePreview(
      {required String token});
}
