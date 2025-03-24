part of 'total_sales_cubit.dart';

@immutable
sealed class TotalSalesState {}

final class TotalSalesInitial extends TotalSalesState {}

final class TotalSalesLoading extends TotalSalesState {}

final class TotalSalesSuccess extends TotalSalesState {
  final TotalSalesEntity totalSalesEntity;

  TotalSalesSuccess(this.totalSalesEntity);
}

final class TotalSalesFailure extends TotalSalesState {
  final String message;

  TotalSalesFailure(this.message);
}
