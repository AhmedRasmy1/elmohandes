import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/update_product_entity.dart';
import 'package:elmohandes/features/home/domain/reposatory/update_product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProductUseCase {
  final UpdateProductRepo updateProductRepo;
  UpdateProductUseCase(this.updateProductRepo);

  Future<Result<UpdateProductEntity>> updateProduct({
    required int id,
    required String name,
    required String countryOfOrigin,
    required num price,
    required num quantity,
    required num discount,
  }) {
    return updateProductRepo.updateProduct(
      id: id,
      name: name,
      countryOfOrigin: countryOfOrigin,
      price: price,
      quantity: quantity,
      discount: discount,
    );
  }
}
