import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/invoice/domain/use_case/delete_one_invoices_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'pay_partial_state.dart';

@injectable
class PayPartialCubit extends Cubit<PayPartialState> {
  final PayPartialUseCase _payPartialUseCase;
  PayPartialCubit(this._payPartialUseCase) : super(PayPartialInitial());
  Future<void> payPartial({
    required String id,
    required double amount,
  }) async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(PayPartialLoading());
    try {
      final result = await _payPartialUseCase.payPartial(
        id: id,
        token: token,
        amount: amount,
      );

      if (result is Fail || result is Fail<void> || result is Fail<dynamic>) {
        emit(PayPartialError(message: "فشل في الدفع الجزئي"));
      } else {
        emit(PayPartialSuccess(message: "تم الدفع الجزئي بنجاح"));
      }
    } catch (e) {
      emit(PayPartialError(message: "حدث خطأ غير متوقع أثناء الدفع الجزئي"));
    }
  }
}
