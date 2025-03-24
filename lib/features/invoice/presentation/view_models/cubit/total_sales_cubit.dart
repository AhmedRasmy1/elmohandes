import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/invoice/domain/entities/total_sales_entity.dart';
import 'package:elmohandes/features/invoice/domain/use_case/total_sales_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'total_sales_state.dart';

@injectable
class TotalSalesCubit extends Cubit<TotalSalesState> {
  final TotalSalesUseCase _totalSalesUseCase;
  TotalSalesCubit(this._totalSalesUseCase) : super(TotalSalesInitial());

  Future<void> getTotalSales() async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(TotalSalesLoading());
    final result = await _totalSalesUseCase.getTotalSales(token);
    switch (result) {
      case Success<TotalSalesEntity>():
        emit(TotalSalesSuccess(result.data));
        break;
      case Fail<TotalSalesEntity>():
        emit(TotalSalesFailure('Error'));
        break;
    }
  }
}
