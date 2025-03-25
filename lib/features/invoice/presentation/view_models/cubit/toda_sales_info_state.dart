part of 'toda_sales_info_cubit.dart';

@immutable
sealed class TodaSalesInfoState {}

final class TodaSalesInfoInitial extends TodaSalesInfoState {}

final class TodaSalesInfoLoading extends TodaSalesInfoState {}

final class TodaSalesInfoSuccess extends TodaSalesInfoState {
  final TodaySalesInfoEntity todaySalesInfoEntity;

  TodaSalesInfoSuccess(this.todaySalesInfoEntity);
}

final class TodaSalesInfoFailure extends TodaSalesInfoState {
  final String message;

  TodaSalesInfoFailure(this.message);
}
