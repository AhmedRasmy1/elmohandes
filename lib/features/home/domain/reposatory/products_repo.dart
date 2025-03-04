import '../../../../core/common/api_result.dart';
import '../entities/products_entity.dart';

abstract class ProductsRepo {
  Future<Result<List<ProductsEntity>>> getAllProducts();
}
