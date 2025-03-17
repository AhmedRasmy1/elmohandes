import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/orders/domain/entities/add_invoice_entity.dart';
import 'package:elmohandes/features/orders/domain/use_cases/add_invoice_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_invoice_state.dart';

@injectable
class AddInvoiceCubit extends Cubit<AddInvoiceState> {
  final AddInvoiceUseCase _addInvoiceUseCase;
  AddInvoiceCubit(this._addInvoiceUseCase) : super(AddInvoiceInitial());

  Future<void> addInvoice(
      {required String token,
      required String customerName,
      required String customerPhone,
      required String payType}) async {
    emit(AddInvoiceLoading());
    final result = await _addInvoiceUseCase.addInvoice(
        token: token,
        customerName: customerName,
        customerPhone: customerPhone,
        payType: payType);
    switch (result) {
      case Success<AddInvoiceEntity>():
        emit(AddInvoiceSuccess(result.data));
        break;
      case Fail<AddInvoiceEntity>():
        emit(AddInvoiceFailure('Failed to add invoice'));
        break;
    }
  }
}
