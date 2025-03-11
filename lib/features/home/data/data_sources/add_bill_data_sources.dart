import '../../../../core/common/api_result.dart';
import '../../domain/entities/add_bill_entity.dart';

abstract class AddBillDataSources {
  Future<Result<AddBillEntity>> addBill({
    required int id,
    required String token,
    required String customerName,
    required String customerPhone,
    required String payType,
    required num amount,
  });
}
