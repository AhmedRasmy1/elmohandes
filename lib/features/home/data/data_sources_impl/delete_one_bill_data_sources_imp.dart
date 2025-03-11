import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources/delete_one_bill_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteOneBillDataSources)
class DeleteOneBillDataSourcesImp implements DeleteOneBillDataSources {
  ApiService apiService;

  DeleteOneBillDataSourcesImp(this.apiService);
  @override
  Future deleteAllBills(String id, String token) {
    return apiService.deleteOneBill(id, token);
  }
}
