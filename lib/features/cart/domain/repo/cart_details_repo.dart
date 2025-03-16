import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/cart/domain/entities/cart_details_entity.dart';

abstract class CartDetailRepo {
  Future<Result<List<CartDetailsEntity>>> getCartDetails(String token);
}
