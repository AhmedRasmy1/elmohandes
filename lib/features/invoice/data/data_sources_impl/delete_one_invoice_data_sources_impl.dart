import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources/delete_one_invoice_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteOneInvoiceDataSources)
class DeleteOneInvoiceDataSourcesImpl implements DeleteOneInvoiceDataSources {
  ApiService apiService;
  DeleteOneInvoiceDataSourcesImpl({required this.apiService});
  @override
  Future deleteOneInvoice({required String id, required String token}) {
    return apiService.deleteOneInvoice(id, token);
  }
}
//------------------------------------------------------------------------

@Injectable(as: PayFullDataSources)
class PayFullDataSourcesImpl implements PayFullDataSources {
  ApiService apiService;
  PayFullDataSourcesImpl({required this.apiService});
  @override
  Future payFull({required String id, required String token}) {
    return apiService.payFull(id, token);
  }
}
