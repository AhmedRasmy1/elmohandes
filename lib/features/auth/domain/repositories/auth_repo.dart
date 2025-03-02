import '../../../../core/common/api_result.dart';
import '../entities/auth_entities.dart';

abstract class LoginRepo {
  Future<Result<LoginEntity>> login(String email, String password);
}
