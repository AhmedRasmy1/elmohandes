import 'package:bloc/bloc.dart';
import '../../../../../core/common/api_result.dart';
import '../../../../../core/utils/cashed_data_shared_preferences.dart';
import '../../../domain/use_case/delete_one_invoices_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'delete_one_invoices_state.dart';

@injectable
class DeleteOneInvoicesCubit extends Cubit<DeleteOneInvoicesState> {
  final DeleteOneInvoicesUseCase _deleteOneInvoicesUseCase;
  DeleteOneInvoicesCubit(this._deleteOneInvoicesUseCase)
      : super(DeleteOneInvoicesInitial());

  Future<void> deleteOneInvoice({required String id}) async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(DeleteOneInvoicesLoading());
    final result =
        await _deleteOneInvoicesUseCase.deleteOneInvoice(id: id, token: token);
    switch (result) {
      case Success<void>():
        emit(DeleteOneInvoicesSuccess("Invoice deleted successfully"));
        break;
      case Fail<void>():
        emit(DeleteOneInvoicesFailure("Error"));
        break;
    }
  }
}
