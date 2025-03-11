import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources/delete_all_bills_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteAllBillsDataSources)
class DeleteAllBillsDataSourcesImpl implements DeleteAllBillsDataSources {
  ApiService apiService;

  DeleteAllBillsDataSourcesImpl(this.apiService);
  @override
  Future deleteAllBills(String token) {
    return apiService.deleteAllBills(token);
  }
}
