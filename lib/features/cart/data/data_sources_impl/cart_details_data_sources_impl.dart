import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/cart_details_data_sources.dart';
import '../../domain/entities/cart_details_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartDetailsDataSources)
class CartDetailsDataSourcesImpl implements CartDetailsDataSources {
  ApiService apiService;
  CartDetailsDataSourcesImpl(this.apiService);
  @override
  Future<Result<List<CartDetailsEntity>>> getCartDetails(String token) {
    return executeApi(() async {
      var response = await apiService.getCartDetails(token);
      var data = response
          .map((cartDetails) => cartDetails.toCartDetailsEntity())
          .toList();
      return data;
    });
  }
}
