import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/home/domain/entities/bills_entity.dart';
import 'package:elmohandes/features/home/domain/use_case/bills_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'bills_state.dart';

@injectable
class BillsCubit extends Cubit<BillsState> {
  final BillsUseCase _billsUseCase;
  BillsCubit(this._billsUseCase) : super(BillsInitial());

  List<BillsEntity> allBills = []; // تخزين جميع الفواتير للأدمن

  Future<void> getAllBills() async {
    emit(BillsLoading());
    final token =
        'Bearer ' + (await CacheService.getData(key: CacheConstants.userToken));
    final result = await _billsUseCase.getAllBills(token);
    switch (result) {
      case Success<List<BillsEntity>>():
        allBills = result.data;
        emit(BillsSuccess(allBills));
        break;
      case Fail<List<BillsEntity>>():
        emit(BillsError("Error"));
        break;
    }
  }

  // === دالة البحث عن فاتورة برقمها ===
  void searchBillById(String billId) {
    final filteredBills =
        allBills.where((bill) => bill.id.toString() == billId.trim()).toList();

    emit(BillsSuccess(filteredBills));
  }
}
