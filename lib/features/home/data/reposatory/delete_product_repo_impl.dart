import 'package:elmohandes/features/home/data/data_sources/delete_product_data_sources.dart';
import 'package:elmohandes/features/home/domain/reposatory/delete_product.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteProduct)
class DeleteProductRepoImpl implements DeleteProduct {
  DeleteProductDataSources deleteProductDataSources;
  DeleteProductRepoImpl({required this.deleteProductDataSources});
  @override
  Future deleteProduct(int id) {
    return deleteProductDataSources.deleteProduct(id);
  }
}
