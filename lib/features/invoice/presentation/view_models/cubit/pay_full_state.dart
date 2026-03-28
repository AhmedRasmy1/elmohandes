part of 'pay_full_cubit.dart';

@immutable
sealed class PayFullState {}

final class PayFullInitial extends PayFullState {}

final class PayFullLoading extends PayFullState {}

final class PayFullSuccess extends PayFullState {
  final String message;

  PayFullSuccess(this.message);
}

final class PayFullFailure extends PayFullState {
  final String message;

  PayFullFailure(this.message);
}

final class PayFullError extends PayFullState {
  final String message;

  PayFullError(this.message);
}
