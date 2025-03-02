import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/products_entity.dart';
import 'package:elmohandes/features/home/domain/reposatory/products_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsUseCase {
  final ProductsRepo productsRepo;
  ProductsUseCase(this.productsRepo);
  Future<Result<List<ProductsEntity>>> getAllProducts() {
    return productsRepo.getAllProducts();
  }
}
