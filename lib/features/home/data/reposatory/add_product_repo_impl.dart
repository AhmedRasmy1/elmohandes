import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/data_sources/add_product_data_sources.dart';
import 'package:elmohandes/features/home/domain/entities/add_product_entity.dart';
import 'package:elmohandes/features/home/domain/reposatory/add_product_repo.dart';
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
