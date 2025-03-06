import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/add_bill_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/add_bill_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddBillDataSources)
class AddBillDataSourcesImpl implements AddBillDataSources {
  ApiService apiService;
  AddBillDataSourcesImpl(this.apiService);
  @override
  Future<Result<AddBillEntity>> addBill(
      {required int id,
      required String token,
      required String customerName,
      required String customerPhone,
      required String payType,
      required num amount}) {
    return executeApi(() async {
      var response = await apiService.addBill(
        id,
        token,
        customerName,
        customerPhone,
        payType,
        amount,
      );
      var data = response.toAddBillEntity();
      return data;
    });
  }
}
