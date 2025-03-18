import '../data_sources/delete_product_from_cart_data_sources.dart';
import '../../domain/repo/delete_product_from_cart_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteProductFromCartRepo)
class DeleteProductFromCartRepoImpl implements DeleteProductFromCartRepo {
  DeleteProductFromCartDataSources deleteProductFromCartDataSources;
  DeleteProductFromCartRepoImpl(this.deleteProductFromCartDataSources);
  @override
  Future deleteProductFromCart(int id, String token) {
    return deleteProductFromCartDataSources.deleteProductFromCart(id, token);
  }
}
