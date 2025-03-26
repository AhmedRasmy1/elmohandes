import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/preview_invoice_entity.dart';

abstract class PreviewInvoiceRepo {
  Future<Result<PreviewInvoiceEntity>> getInvoicePreview(
      {required String token});
}
