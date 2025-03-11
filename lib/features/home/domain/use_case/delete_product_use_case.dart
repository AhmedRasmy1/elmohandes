import '../reposatory/delete_product.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteProductUseCase {
  final DeleteProduct deleteProductt;
  DeleteProductUseCase(this.deleteProductt);

  Future deleteProduct(int id) {
    return deleteProductt.deleteProduct(id);
  }
}
