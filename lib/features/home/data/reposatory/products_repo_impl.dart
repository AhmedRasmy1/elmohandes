import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/products_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/products_entity.dart';
import 'package:elmohandes/features/home/domain/reposatory/products_repo.dart';
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
