part of 'pay_partial_cubit.dart';

@immutable
sealed class PayPartialState {}

final class PayPartialInitial extends PayPartialState {}

final class PayPartialLoading extends PayPartialState {}

final class PayPartialSuccess extends PayPartialState {
  final String? message;

  PayPartialSuccess({this.message});
}

final class PayPartialError extends PayPartialState {
  final String? message;

  PayPartialError({this.message});
}
