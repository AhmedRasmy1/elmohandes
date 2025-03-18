import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources/add_product_to_cart_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddProductToCartDataSources)
class AddProductToCartDataSourcesImpl implements AddProductToCartDataSources {
  ApiService apiService;

  AddProductToCartDataSourcesImpl(this.apiService);
  @override
  Future addProductToCart(int id, String token, int quantity) {
    return apiService.addProductToCart(id, token, quantity);
  }
}
