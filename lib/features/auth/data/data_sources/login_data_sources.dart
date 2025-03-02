import '../../../../core/common/api_result.dart';
import '../../domain/entities/auth_entities.dart';

abstract class LoginDataSources {
  Future<Result<LoginEntity>> login(String email, String password);
}
