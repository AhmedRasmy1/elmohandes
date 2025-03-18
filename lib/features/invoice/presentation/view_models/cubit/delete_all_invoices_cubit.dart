import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/invoice/domain/use_case/delete_all_invoices_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'delete_all_invoices_state.dart';

@injectable
class DeleteAllInvoicesCubit extends Cubit<DeleteAllInvoicesState> {
  final DeleteAllInvoicesUseCase _deleteAllInvoicesUseCase;
  DeleteAllInvoicesCubit(this._deleteAllInvoicesUseCase)
      : super(DeleteAllInvoicesInitial());

  Future<void> deleteAllInvoices() async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(DeleteAllInvoicesLoading());
    final result =
        await _deleteAllInvoicesUseCase.deleteAllInvoices(token: token);
    switch (result) {
      case Success<void>():
        emit(DeleteAllInvoicesSuccess("Invoices deleted successfully"));
        break;
      case Fail<void>():
        emit(DeleteAllInvoicesFailure("Error"));
        break;
    }
  }
}
