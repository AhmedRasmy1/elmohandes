import '../../../../core/common/api_result.dart';
import '../entities/cart_details_entity.dart';

abstract class CartDetailRepo {
  Future<Result<List<CartDetailsEntity>>> getCartDetails(String token);
}
