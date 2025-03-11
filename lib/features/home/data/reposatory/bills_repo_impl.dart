import '../../../../core/common/api_result.dart';
import '../data_sources/bills_data_sources.dart';
import '../../domain/entities/bills_entity.dart';
import '../../domain/reposatory/bills_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BillsRepo)
class BillsRepoImpl implements BillsRepo {
  BillsDataSources billsDataSources;
  BillsRepoImpl(this.billsDataSources);
  @override
  Future<Result<List<BillsEntity>>> getAllBills(String token) {
    return billsDataSources.getAllBills(token);
  }
}
