import '../data_sources/delete_one_bill_data_sources.dart';
import '../../domain/reposatory/delete_one_bill.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteOneBillRepo)
class DeleteOneBillRepoImpl implements DeleteOneBillRepo {
  DeleteOneBillDataSources deleteOneBillDataSources;
  DeleteOneBillRepoImpl(this.deleteOneBillDataSources);
  @override
  Future deleteOneBill(String id, String token) {
    return deleteOneBillDataSources.deleteAllBills(id, token);
  }
}
