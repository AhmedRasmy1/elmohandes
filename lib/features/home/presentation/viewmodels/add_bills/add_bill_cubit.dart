import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../../../core/common/api_result.dart';
import '../../../../../core/utils/cashed_data_shared_preferences.dart';
import '../../../domain/entities/add_bill_entity.dart';
import '../../../domain/use_case/add_bill_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_bill_state.dart';

@injectable
class AddBillCubit extends Cubit<AddBillState> {
  final AddBillUseCase _addBillUseCase;
  AddBillCubit(this._addBillUseCase) : super(AddBillInitial());

  Future<void> addBill({
    required int id,
    required String customerName,
    required String customerPhone,
    required String payType,
    required num amount,
  }) async {
    emit(AddBillLoading());
    final token =
        'Bearer ' + (await CacheService.getData(key: CacheConstants.userToken));
    final result = await _addBillUseCase.addBill(
      id: id,
      token: token,
      customerName: customerName,
      customerPhone: customerPhone,
      payType: payType,
      amount: amount,
    );
    switch (result) {
      case Success<AddBillEntity>():
        emit(AddBillSuccess(result.data));
        log('result.data = ${result.data}');
        break;
      case Fail<AddBillEntity>():
        emit(AddBillFailure('Error'));
        log('Error');
        break;
    }
  }
}
