import '../../../../core/common/api_result.dart';
import '../data_sources_impl/data_sources_impl.dart';
import '../../domain/entities/auth_entities.dart';
import '../../domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  LoginDataSourceImpl loginDataSourceImpl;
  LoginRepoImpl(this.loginDataSourceImpl);
  @override
  Future<Result<LoginEntity>> login(String email, String password) {
    return loginDataSourceImpl.login(email, password);
  }
}
