import '../../../../core/common/api_result.dart';
import '../data_sources/add_bill_data_sources.dart';
import '../../domain/entities/add_bill_entity.dart';
import '../../domain/reposatory/add_bill_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddBillRepo)
class AddBillRepoImpl implements AddBillRepo {
  AddBillDataSources addBillDataSources;
  AddBillRepoImpl(this.addBillDataSources);
  @override
  Future<Result<AddBillEntity>> addBill(
      {required int id,
      required String token,
      required String customerName,
      required String customerPhone,
      required String payType,
      required num amount}) {
    return addBillDataSources.addBill(
      id: id,
      token: token,
      customerName: customerName,
      customerPhone: customerPhone,
      payType: payType,
      amount: amount,
    );
  }
}
