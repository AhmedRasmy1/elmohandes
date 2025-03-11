import '../../../../core/common/api_result.dart';
import '../../domain/entities/update_product_entity.dart';

abstract class UpdateProductDataSources {
  Future<Result<UpdateProductEntity>> updateProduct({
    required int id,
    required String name,
    required String countryOfOrigin,
    required num price,
    required num quantity,
    required num discount,
  });
}
