import 'package:elmohandes/core/api/api_extentions.dart';
import 'package:elmohandes/core/api/api_manager/api_manager.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/auth/data/data_sources/login_data_sources.dart';
import 'package:elmohandes/features/auth/domain/entities/auth_entities.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginDataSourceImpl implements LoginDataSources {
  ApiService apiService;
  LoginDataSourceImpl(this.apiService);
  @override
  Future<Result<LoginEntity>> login(String email, String password) {
    return executeApi(() async {
      var response = await apiService.login(email, password);
      var data = response.toLoginEntity();
      return data;
    });
  }
}
