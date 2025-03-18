import '../../../../core/common/api_result.dart';
import '../../domain/entities/cart_details_entity.dart';

abstract class CartDetailsDataSources {
  Future<Result<List<CartDetailsEntity>>> getCartDetails(String token);
}
