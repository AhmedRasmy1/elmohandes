part of 'preview_invoice_cubit.dart';

@immutable
sealed class PreviewInvoiceState {}

final class PreviewInvoiceInitial extends PreviewInvoiceState {}

final class PreviewInvoiceLoading extends PreviewInvoiceState {}

final class PreviewInvoiceSuccess extends PreviewInvoiceState {
  final PreviewInvoiceEntity previewInvoiceEntity;

  PreviewInvoiceSuccess(this.previewInvoiceEntity);
}

final class PreviewInvoiceFailure extends PreviewInvoiceState {
  final String message;

  PreviewInvoiceFailure(this.message);
}
