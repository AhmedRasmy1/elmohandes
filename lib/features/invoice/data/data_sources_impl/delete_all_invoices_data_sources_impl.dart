import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources/delete_all_invoices_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteAllInvoicesDataSources)
class DeleteAllInvoicesDataSourcesImpl implements DeleteAllInvoicesDataSources {
  ApiService apiService;

  DeleteAllInvoicesDataSourcesImpl(this.apiService);
  @override
  Future deleteAllInvoices({required String token}) {
    return apiService.deleteAllInvoices(token);
  }
}
