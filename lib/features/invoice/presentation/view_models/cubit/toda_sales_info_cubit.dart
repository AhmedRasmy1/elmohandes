import 'package:bloc/bloc.dart';
import '../../../../../core/common/api_result.dart';
import '../../../../../core/utils/cashed_data_shared_preferences.dart';
import '../../../domain/entities/today_sales_info_entity.dart';
import '../../../domain/use_case/today_sales_info_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'toda_sales_info_state.dart';

@injectable
class TodaSalesInfoCubit extends Cubit<TodaSalesInfoState> {
  final TodaySalesInfoUseCase _todaySalesInfoUseCase;
  TodaSalesInfoCubit(this._todaySalesInfoUseCase)
      : super(TodaSalesInfoInitial());

  Future<void> getTotalSalesByDate() async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(TodaSalesInfoLoading());
    final result =
        await _todaySalesInfoUseCase.getTotalSalesByDate(token: token);

    switch (result) {
      case Success<TodaySalesInfoEntity>():
        emit(TodaSalesInfoSuccess(result.data));
        break;
      case Fail<TodaySalesInfoEntity>():
        emit(TodaSalesInfoFailure('Error'));
        break;
    }
  }
}
