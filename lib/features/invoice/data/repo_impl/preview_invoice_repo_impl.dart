import '../../../../core/common/api_result.dart';
import '../data_sources/preview_invoice_data_sources.dart';
import '../../domain/entities/preview_invoice_entity.dart';
import '../../domain/repo/preview_invoice_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PreviewInvoiceRepo)
class PreviewInvoiceRepoImpl implements PreviewInvoiceRepo {
  PreviewInvoiceDataSources previewInvoiceDataSources;

  PreviewInvoiceRepoImpl({required this.previewInvoiceDataSources});

  @override
  Future<Result<PreviewInvoiceEntity>> getInvoicePreview(
      {required String token}) {
    return previewInvoiceDataSources.getInvoicePreview(token);
  }
}
