import '../../../../core/common/api_result.dart';
import '../entities/products_entity.dart';
import '../reposatory/products_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsUseCase {
  final ProductsRepo productsRepo;
  ProductsUseCase(this.productsRepo);
  Future<Result<List<ProductsEntity>>> getAllProducts() {
    return productsRepo.getAllProducts();
  }
}
