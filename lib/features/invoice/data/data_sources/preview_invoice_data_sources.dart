import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/preview_invoice_entity.dart';

abstract class PreviewInvoiceDataSources {
  Future<Result<PreviewInvoiceEntity>> getInvoicePreview(String token);
}
