import 'package:elmohandes/features/cart/domain/repo/add_product_to_cart_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUseCase {
  AddProductToCartRepo addProductToCartRepo;
  AddProductToCartUseCase(this.addProductToCartRepo);
  Future addProductToCart(int id, String token, int quantity) {
    return addProductToCartRepo.addProductToCart(id, token, quantity);
  }
}
