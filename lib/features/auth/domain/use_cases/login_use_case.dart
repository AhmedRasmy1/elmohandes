import '../../../../core/common/api_result.dart';
import '../entities/auth_entities.dart';
import '../repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);
  Future<Result<LoginEntity>> login(String email, String password) {
    return loginRepo.login(email, password);
  }
}
