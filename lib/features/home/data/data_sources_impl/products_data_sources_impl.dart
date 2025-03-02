import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/products_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/products_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsDataSources)
class ProductsDataSourcesImpl implements ProductsDataSources {
  ApiService apiService;
  ProductsDataSourcesImpl(this.apiService);
  @override
  Future<Result<List<ProductsEntity>>> getAllProducts() {
    return executeApi<List<ProductsEntity>>(() async {
      var response = await apiService.getAllProducts();
      var data = response.map((product) => product.toProductsEntity()).toList();
      return data;
    });
  }
}
