import 'package:dio/dio.dart';
import '../../../../core/common/api_result.dart';
import '../entities/add_product_entity.dart';

abstract class AddProductRepo {
  Future<Result<AddProductEntity>> addProduct({required FormData formData});
}
