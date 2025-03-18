import '../repo/delete_product_from_cart_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteProductFromCartUseCase {
  DeleteProductFromCartRepo deleteProductFromCartRepo;
  DeleteProductFromCartUseCase(this.deleteProductFromCartRepo);
  Future deleteProductFromCart(int id, String token) {
    return deleteProductFromCartRepo.deleteProductFromCart(id, token);
  }
}
