part of 'delete_one_invoices_cubit.dart';

@immutable
sealed class DeleteOneInvoicesState {}

final class DeleteOneInvoicesInitial extends DeleteOneInvoicesState {}

final class DeleteOneInvoicesLoading extends DeleteOneInvoicesState {}

final class DeleteOneInvoicesSuccess extends DeleteOneInvoicesState {
  final String message;

  DeleteOneInvoicesSuccess(this.message);
}

final class DeleteOneInvoicesFailure extends DeleteOneInvoicesState {
  final String message;

  DeleteOneInvoicesFailure(this.message);
}
