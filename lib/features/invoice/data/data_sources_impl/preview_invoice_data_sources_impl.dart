import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/preview_invoice_data_sources.dart';
import '../../domain/entities/preview_invoice_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PreviewInvoiceDataSources)
class PreviewInvoiceDataSourcesImpl implements PreviewInvoiceDataSources {
  ApiService apiService;

  PreviewInvoiceDataSourcesImpl(this.apiService);
  @override
  Future<Result<PreviewInvoiceEntity>> getInvoicePreview(String token) {
    return executeApi(() async {
      var response = await apiService.getInvoicePreview(token);
      var data = response.toPreviewInvoiceEntity();
      return data;
    });
  }
}
