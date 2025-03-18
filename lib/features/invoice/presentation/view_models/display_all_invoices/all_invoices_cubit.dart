import 'package:bloc/bloc.dart';
import '../../../../../core/common/api_result.dart';
import '../../../../../core/utils/cashed_data_shared_preferences.dart';
import '../../../domain/entities/all_invoices_entity.dart';
import '../../../domain/use_case/all_invoices_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'all_invoices_state.dart';

@injectable
class AllInvoicesCubit extends Cubit<AllInvoicesState> {
  final AllInvoicesUseCase _allInvoicesUseCase;
  AllInvoicesCubit(this._allInvoicesUseCase) : super(AllInvoicesInitial());

  Future<void> getAllInvoices() async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(AllInvoicesLoading());
    final result = await _allInvoicesUseCase.getAllInvoices(token);
    switch (result) {
      case Success<List<AllInvoiceEntity>>():
        emit(AllInvoicesSuccess(result.data));
        break;
      case Fail<List<AllInvoiceEntity>>():
        emit(AllInvoicesFailure('Error'));
        break;
    }
  }
}
