import '../../../../core/common/api_result.dart';
import '../data_sources/products_data_sources.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/reposatory/products_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  ProductsDataSources productsDataSources;
  ProductsRepoImpl(this.productsDataSources);
  @override
  Future<Result<List<ProductsEntity>>> getAllProducts() {
    return productsDataSources.getAllProducts();
  }
}
