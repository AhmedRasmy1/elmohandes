import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/invoice/domain/entities/preview_invoice_entity.dart';
import 'package:elmohandes/features/invoice/domain/use_case/preview_invoice_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'preview_invoice_state.dart';

@injectable
class PreviewInvoiceCubit extends Cubit<PreviewInvoiceState> {
  final PreviewInvoiceUseCase _previewInvoiceUseCase;
  PreviewInvoiceCubit(this._previewInvoiceUseCase)
      : super(PreviewInvoiceInitial());

  Future<void> getInvoicePreview() async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(PreviewInvoiceLoading());
    final result = await _previewInvoiceUseCase.getInvoicePreview(token: token);
    switch (result) {
      case Success<PreviewInvoiceEntity>():
        emit(PreviewInvoiceSuccess(result.data));
        break;
      case Fail<PreviewInvoiceEntity>():
        emit(PreviewInvoiceFailure("لا توجد منتجات في السلة"));
        break;
    }
  }
}
