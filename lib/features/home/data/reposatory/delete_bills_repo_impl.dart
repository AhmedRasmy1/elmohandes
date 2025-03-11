import '../data_sources/delete_all_bills_data_sources.dart';
import '../../domain/reposatory/delete_all_bills.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteAllBillsRepo)
class DeleteBillsRepoImpl implements DeleteAllBillsRepo {
  DeleteAllBillsDataSources deleteAllBillsDataSources;
  DeleteBillsRepoImpl(this.deleteAllBillsDataSources);
  @override
  Future deleteAllBills(String token) {
    return deleteAllBillsDataSources.deleteAllBills(token);
  }
}
