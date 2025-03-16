import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/cart/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'delete_cart_product_state.dart';

@injectable
class DeleteCartProductCubit extends Cubit<DeleteCartProductState> {
  final DeleteProductFromCartUseCase _deleteProductFromCartUseCase;
  DeleteCartProductCubit(this._deleteProductFromCartUseCase)
      : super(DeleteCartProductInitial());

  Future<void> deleteProductFromCart(int id) async {
    final token =
        'Bearer ${await CacheService.getData(key: CacheConstants.userToken)}';
    emit(DeleteCartProductLoading());
    final result =
        await _deleteProductFromCartUseCase.deleteProductFromCart(id, token);
    switch (result) {
      case Success<void>():
        emit(
            DeleteCartProductSuccess("Product deleted from cart successfully"));
        break;
      case Fail<void>():
        emit(DeleteCartProductFailure("Error"));
        break;
    }
  }
}
