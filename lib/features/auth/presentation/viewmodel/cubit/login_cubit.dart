import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/auth/domain/entities/auth_entities.dart';
import 'package:elmohandes/features/auth/domain/use_cases/login_use_case.dart';
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
