import 'package:elmohandes/features/cart/domain/repo/cart_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartDetailsUseCase {
  CartDetailRepo cartDetailRepo;
  CartDetailsUseCase(this.cartDetailRepo);
  Future getCartDetails(String token) {
    return cartDetailRepo.getCartDetails(token);
  }
}
