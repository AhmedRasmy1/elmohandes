import '../../../../core/common/api_result.dart';
import '../../domain/entities/products_entity.dart';

abstract class ProductsDataSources {
  Future<Result<List<ProductsEntity>>> getAllProducts();
}
