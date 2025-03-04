import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/add_product_entity.dart';
import 'package:dio/dio.dart';

abstract class AddProductDataSources {
  Future<Result<AddProductEntity>> addProduct({
    required FormData formData,
  });
}
