import '../../../../core/common/api_result.dart';
import '../data_sources/cart_details_data_sources.dart';
import '../../domain/entities/cart_details_entity.dart';
import '../../domain/repo/cart_details_repo.dart';
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
