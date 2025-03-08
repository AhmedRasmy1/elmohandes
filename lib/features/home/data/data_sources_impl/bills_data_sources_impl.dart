import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/bills_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/bills_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BillsDataSources)
class BillsDataSourcesImpl implements BillsDataSources {
  ApiService apiService;

  BillsDataSourcesImpl(this.apiService);
  @override
  Future<Result<List<BillsEntity>>> getAllBills(String token) {
    return executeApi(() async {
      var response = await apiService.getAllBills(token);
      var data = response.map((bill) => bill.toBillsEntity()).toList();
      return data;
    });
  }
}
