import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_product_to_cart_state.dart';

@injectable
class AddProductToCartCubit extends Cubit<AddProductToCartState> {
  final AddProductToCartUseCase _addProductToCartUseCase;
  AddProductToCartCubit(this._addProductToCartUseCase)
      : super(AddProductToCartInitial());

  Future<void> addProductToCart(int id, int quantity) async {
    final token =
        'Bearer ${await CacheService.getData(key: CacheConstants.userToken)}';
    emit(AddProductToCartLoading());
    final result =
        await _addProductToCartUseCase.addProductToCart(id, token, quantity);
    switch (result) {
      case Success<void>():
        emit(AddProductToCartSuccess("Product added to cart successfully"));
        break;
      case Fail<void>():
        emit(AddProductToCartFailure("Error"));
        break;
    }
  }
}
