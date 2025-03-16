import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/cart/data/data_sources/cart_details_data_sources.dart';
import 'package:elmohandes/features/cart/domain/entities/cart_details_entity.dart';
import 'package:elmohandes/features/cart/domain/repo/cart_details_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartDetailRepo)
class CartDetailsRepoImpl implements CartDetailRepo {
  CartDetailsDataSources cartDetailsDataSources;
  CartDetailsRepoImpl(this.cartDetailsDataSources);
  @override
  Future<Result<List<CartDetailsEntity>>> getCartDetails(String token) {
    return cartDetailsDataSources.getCartDetails(token);
  }
}
