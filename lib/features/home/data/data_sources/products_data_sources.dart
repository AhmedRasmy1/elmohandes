import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/products_entity.dart';

abstract class ProductsDataSources {
  Future<Result<List<ProductsEntity>>> getAllProducts();
}
