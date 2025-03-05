import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/update_product_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/update_product_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdateProductDataSources)
class UpdateProductDataSourcesImpl implements UpdateProductDataSources {
  ApiService apiService;
  UpdateProductDataSourcesImpl(this.apiService);
  @override
  Future<Result<UpdateProductEntity>> updateProduct(
      {required int id,
      required String name,
      required String countryOfOrigin,
      required num price,
      required num quantity,
      required num discount}) {
    return executeApi(() async {
      var response = await apiService.updateProduct(
        id,
        name,
        countryOfOrigin,
        price,
        quantity,
        discount,
      );
      var data = response.toUpdateProductEntity();
      return data;
    });
  }
}
