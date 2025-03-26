import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/preview_invoice_entity.dart';
import 'package:elmohandes/features/invoice/domain/repo/preview_invoice_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class PreviewInvoiceUseCase {
  PreviewInvoiceRepo previewInvoiceRepo;

  PreviewInvoiceUseCase(this.previewInvoiceRepo);

  Future<Result<PreviewInvoiceEntity>> getInvoicePreview(
          {required String token}) =>
      previewInvoiceRepo.getInvoicePreview(token: token);
}
