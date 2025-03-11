import 'package:injectable/injectable.dart';

import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../../domain/entities/auth_entities.dart';
import '../data_sources/login_data_sources.dart';

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
