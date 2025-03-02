import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import '../../../../../core/common/api_result.dart';
import '../../../domain/entities/auth_entities.dart';
import '../../../domain/use_cases/login_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit((LoginLoding()));
    final result = await _loginUseCase.login(email, password);
    switch (result) {
      case Success<LoginEntity>():
        await CacheService.setData(
            key: CacheConstants.userToken, value: result.data.token);
        emit(LoginSuccess(result.data));
        log('=====================> ${result.data}');
        break;
      case Fail<LoginEntity>():
        emit(LoginFailure('Error'));
        log('=====================> ${result.exception}');
        break;
    }
  }
}
