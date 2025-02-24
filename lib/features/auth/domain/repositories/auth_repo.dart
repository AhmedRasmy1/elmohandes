import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/auth/domain/entities/auth_entities.dart';

abstract class LoginRepo {
  Future<Result<LoginEntity>> login(String email, String password);
}
