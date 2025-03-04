import 'package:dio/dio.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/add_product_entity.dart';

abstract class AddProductRepo {
  Future<Result<AddProductEntity>> addProduct({required FormData formData});
}
