import '../../../../core/common/api_result.dart';
import '../entities/add_product_entity.dart';
import '../reposatory/add_product_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@injectable
class AddProductUseCase {
  final AddProductRepo addProductRepo;
  AddProductUseCase(this.addProductRepo);

  Future<Result<AddProductEntity>> addProduct(FormData formData) {
    return addProductRepo.addProduct(formData: formData);
  }
}
