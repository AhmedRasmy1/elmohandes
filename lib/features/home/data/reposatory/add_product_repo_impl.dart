import '../../../../core/common/api_result.dart';
import '../data_sources/add_product_data_sources.dart';
import '../../domain/entities/add_product_entity.dart';
import '../../domain/reposatory/add_product_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@Injectable(as: AddProductRepo)
class AddProductRepoImpl implements AddProductRepo {
  AddProductDataSources addProductDataSources;
  AddProductRepoImpl(this.addProductDataSources);

  @override
  Future<Result<AddProductEntity>> addProduct({
    required FormData formData,
  }) {
    return addProductDataSources.addProduct(formData: formData);
  }
}
