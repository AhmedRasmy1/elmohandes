import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/home/domain/use_case/delete_all_bills_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'delete_all_bills_state.dart';

@injectable
class DeleteAllBillsCubit extends Cubit<DeleteAllBillsState> {
  final DeleteAllBillsUseCase _deleteAllBillsUseCase;
  DeleteAllBillsCubit(this._deleteAllBillsUseCase)
      : super(DeleteAllBillsInitial());

  Future<void> deleteAllBills() async {
    final token =
        'Bearer ' + (await CacheService.getData(key: CacheConstants.userToken));

    emit(DeleteAllBillsLoading());
    final result = await _deleteAllBillsUseCase.deleteAllBills(token);
    switch (result) {
      case Success<void>():
        emit(DeleteAllBillsSuccess());
        break;
      case Fail<void>():
        emit(DeleteAllBillsFailure());
        break;
    }
  }
}
