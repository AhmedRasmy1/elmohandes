import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/cart/domain/entities/cart_details_entity.dart';
import 'package:elmohandes/features/cart/domain/use_cases/cart_details_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'cart_details_state.dart';

@injectable
class CartDetailsCubit extends Cubit<CartDetailsState> {
  final CartDetailsUseCase _cartDetailsUseCase;
  CartDetailsCubit(this._cartDetailsUseCase) : super(CartDetailsInitial());

  Future<void> getCartDetails() async {
    final token =
        'Bearer ${await CacheService.getData(key: CacheConstants.userToken)}';
    emit(CartDetailsLoading());
    final result = await _cartDetailsUseCase.getCartDetails(token);
    switch (result) {
      case Success<List<CartDetailsEntity>>():
        emit(CartDetailsSuccess(result.data));
        break;
      case Fail<List<CartDetailsEntity>>():
        emit(CartDetailsFailure('Error'));
        break;
    }
  }
}
