import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/update_product_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/update_product_entity.dart';
import 'package:elmohandes/features/home/domain/reposatory/update_product_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdateProductRepo)
class UpdateProductRepoImpl implements UpdateProductRepo {
  UpdateProductDataSources updateProductDataSources;
  UpdateProductRepoImpl(this.updateProductDataSources);
  @override
  Future<Result<UpdateProductEntity>> updateProduct(
      {required int id,
      required String name,
      required String countryOfOrigin,
      required num price,
      required num quantity,
      required num discount}) {
    return updateProductDataSources.updateProduct(
      id: id,
      name: name,
      countryOfOrigin: countryOfOrigin,
      price: price,
      quantity: quantity,
      discount: discount,
    );
  }
}
