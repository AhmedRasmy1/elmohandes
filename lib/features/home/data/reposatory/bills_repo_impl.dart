import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/bills_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/bills_entity.dart';
import 'package:elmohandes/features/home/domain/reposatory/bills_repo.dart';
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
