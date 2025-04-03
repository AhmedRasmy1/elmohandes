import '../../../../core/common/api_result.dart';
import '../../domain/entities/preview_invoice_entity.dart';

abstract class PreviewInvoiceDataSources {
  Future<Result<PreviewInvoiceEntity>> getInvoicePreview(String token);
}
