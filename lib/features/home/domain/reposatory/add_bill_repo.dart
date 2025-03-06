import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/add_bill_entity.dart';

abstract class AddBillRepo {
  Future<Result<AddBillEntity>> addBill({
    required int id,
    required String token,
    required String customerName,
    required String customerPhone,
    required String payType,
    required num amount,
  });
}
