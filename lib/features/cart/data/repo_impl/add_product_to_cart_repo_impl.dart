import '../data_sources/add_product_to_cart_data_sources.dart';
import '../../domain/repo/add_product_to_cart_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddProductToCartRepo)
class AddProductToCartRepoImpl implements AddProductToCartRepo {
  AddProductToCartDataSources addProductToCartDataSources;
  AddProductToCartRepoImpl(this.addProductToCartDataSources);

  @override
  Future addProductToCart(int id, String token, int quantity) {
    return addProductToCartDataSources.addProductToCart(id, token, quantity);
  }
}
