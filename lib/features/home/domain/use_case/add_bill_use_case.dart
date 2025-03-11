import '../../../../core/common/api_result.dart';
import '../entities/add_bill_entity.dart';
import '../reposatory/add_bill_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddBillUseCase {
  AddBillRepo addBillRepo;
  AddBillUseCase(this.addBillRepo);
  Future<Result<AddBillEntity>> addBill({
    required int id,
    required String token,
    required String customerName,
    required String customerPhone,
    required String payType,
    required num amount,
  }) {
    return addBillRepo.addBill(
      id: id,
      token: token,
      customerName: customerName,
      customerPhone: customerPhone,
      payType: payType,
      amount: amount,
    );
  }
}
