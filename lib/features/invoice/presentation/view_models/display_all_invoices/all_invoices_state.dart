part of 'all_invoices_cubit.dart';

@immutable
sealed class AllInvoicesState {}

final class AllInvoicesInitial extends AllInvoicesState {}

final class AllInvoicesLoading extends AllInvoicesState {}

final class AllInvoicesSuccess extends AllInvoicesState {
  final List<AllInvoiceEntity> allInvoices;

  AllInvoicesSuccess(this.allInvoices);
}

final class AllInvoicesFailure extends AllInvoicesState {
  final String message;

  AllInvoicesFailure(this.message);
}
