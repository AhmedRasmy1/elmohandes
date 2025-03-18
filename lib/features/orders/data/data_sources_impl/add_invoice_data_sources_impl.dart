import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/add_invoice_data_sources.dart';
import '../../domain/entities/add_invoice_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddInvoiceDataSources)
class AddInvoiceDataSourcesImpl implements AddInvoiceDataSources {
  ApiService apiService;
  AddInvoiceDataSourcesImpl(this.apiService);
  @override
  Future<Result<AddInvoiceEntity>> addInvoice(
      {required String token,
      required String customerName,
      required String customerPhone,
      required String payType}) {
    return executeApi(() async {
      var response = await apiService.addInvoice(
          token, customerName, customerPhone, payType);
      var data = response.toAddInvoiceEntity();
      return data;
    });
  }
}
