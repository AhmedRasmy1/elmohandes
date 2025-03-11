import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/features/home/data/data_sources/delete_product_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteProductDataSources)
class DeleteProductDataSourcesImpl implements DeleteProductDataSources {
  ApiService apiService;

  DeleteProductDataSourcesImpl(this.apiService);
  @override
  Future deleteProduct(int id) {
    return apiService.deleteProduct(id);
  }
}
