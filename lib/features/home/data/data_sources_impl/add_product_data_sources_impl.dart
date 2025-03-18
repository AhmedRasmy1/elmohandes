import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../../domain/entities/add_product_entity.dart';
import '../data_sources/add_product_data_sources.dart';

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
