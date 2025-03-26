import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/data/data_sources/preview_invoice_data_sources.dart';
import 'package:elmohandes/features/invoice/domain/entities/preview_invoice_entity.dart';
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
