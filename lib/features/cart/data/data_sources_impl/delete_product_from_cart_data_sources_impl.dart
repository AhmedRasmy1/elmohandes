import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/features/cart/data/data_sources/delete_product_from_cart_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteProductFromCartDataSources)
class DeleteProductFromCartDataSourcesImpl
    implements DeleteProductFromCartDataSources {
  ApiService apiService;
  DeleteProductFromCartDataSourcesImpl(this.apiService);
  @override
  Future deleteProductFromCart(int id, String token) {
    return apiService.deleteProductFromCart(id, token);
  }
}
