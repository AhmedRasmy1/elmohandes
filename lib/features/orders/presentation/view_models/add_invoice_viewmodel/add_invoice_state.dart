part of 'add_invoice_cubit.dart';

@immutable
sealed class AddInvoiceState {}

final class AddInvoiceInitial extends AddInvoiceState {}

final class AddInvoiceLoading extends AddInvoiceState {}

final class AddInvoiceSuccess extends AddInvoiceState {
  final AddInvoiceEntity data;

  AddInvoiceSuccess(this.data);
}

final class AddInvoiceFailure extends AddInvoiceState {
  final String message;

  AddInvoiceFailure(this.message);
}
