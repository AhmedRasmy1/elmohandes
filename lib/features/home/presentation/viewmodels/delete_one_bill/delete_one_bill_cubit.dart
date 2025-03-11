import 'package:bloc/bloc.dart';
import '../../../../../core/common/api_result.dart';
import '../../../../../core/utils/cashed_data_shared_preferences.dart';
import '../../../domain/use_case/delete_one_bill_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'delete_one_bill_state.dart';

@injectable
class DeleteOneBillCubit extends Cubit<DeleteOneBillState> {
  final DeleteOneBillUseCase _deleteOneBillUseCase;
  DeleteOneBillCubit(this._deleteOneBillUseCase)
      : super(DeleteOneBillInitial());

  Future<void> deleteOneBill(String id) async {
    final token =
        'Bearer ${await CacheService.getData(key: CacheConstants.userToken)}';
    emit(DeleteOneBillLoading());
    var result = await _deleteOneBillUseCase.deleteOneBill(id, token);

    switch (result) {
      case Success<void>():
        emit(DeleteOneBillSuccess('Bill deleted successfully'));
        break;
      case Fail<void>():
        emit(DeleteOneBillFailure('Failed to delete bill'));
        break;
    }
  }
}
