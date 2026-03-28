import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/invoice/domain/use_case/delete_one_invoices_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'pay_full_state.dart';

@injectable
class PayFullCubit extends Cubit<PayFullState> {
  final PayFullUseCase _payFullUseCase;
  PayFullCubit(this._payFullUseCase) : super(PayFullInitial());

  Future<void> payFull({required String id}) async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(PayFullLoading());

    try {
      final result = await _payFullUseCase.payFull(id: id, token: token);

      // التعديل هنا: لو النتيجة فيها أي نوع من أنواع الفشل، هنطلع إيرور
      if (result is Fail || result is Fail<void> || result is Fail<dynamic>) {
        emit(PayFullFailure("حدث خطأ أثناء الدفع"));
      }
      // لو مفيش فشل، ومفيش Exception ضرب فوق، يبقى الريكويست نجح 100%
      else {
        emit(PayFullSuccess("تم الدفع بنجاح"));
      }
    } catch (e) {
      // ده هيصطاد أي مشكلة في النت أو السيرفر
      emit(PayFullFailure("حدث خطأ غير متوقع"));
    }
  }
}
