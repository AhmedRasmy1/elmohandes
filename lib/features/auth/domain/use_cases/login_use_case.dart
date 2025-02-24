import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/auth/domain/entities/auth_entities.dart';
import 'package:elmohandes/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);
  Future<Result<LoginEntity>> login(String email, String password) {
    return loginRepo.login(email, password);
  }
}
