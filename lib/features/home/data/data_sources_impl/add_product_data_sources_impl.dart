import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/add_product_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/add_product_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@Injectable(as: AddProductDataSources)
class AddProductDataSourcesImpl implements AddProductDataSources {
  ApiService apiService;
  AddProductDataSourcesImpl(this.apiService);

  @override
  Future<Result<AddProductEntity>> addProduct({
    required FormData formData,
  }) {
    return executeApi(() async {
      var response = await apiService.addProduct(formData);
      var data = response.toAddProductEntity();
      return data;
    });
  }
}
