import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/data/data_sources/all_invoices_data_sources.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_invoices_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AllInvoicesDataSources)
class AllInvoicesDataSourcesImpl implements AllInvoicesDataSources {
  ApiService apiService;
  AllInvoicesDataSourcesImpl(this.apiService);
  @override
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(
      {required String token}) {
    return executeApi(() async {
      var response = await apiService.getAllInvoices(token);
      var data =
          response.map((invoices) => invoices.toAllInvoiceEntity()).toList();
      return data;
    });
  }
}
