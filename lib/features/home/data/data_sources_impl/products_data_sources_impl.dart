import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/products_data_sources.dart';
import '../../domain/entities/products_entity.dart';
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
