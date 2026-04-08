part of 'all_cutsomer_cubit.dart';

@immutable
sealed class AllCutsomerState {}

final class AllCutsomerInitial extends AllCutsomerState {}

final class AllCutsomerLoaded extends AllCutsomerState {}

final class AllCutsomerSuccess extends AllCutsomerState {
  final List<AllCustomersEntity> allCustomers;

  AllCutsomerSuccess(this.allCustomers);
}

final class AllCutsomerError extends AllCutsomerState {
  final String message;

  AllCutsomerError(this.message);
}
