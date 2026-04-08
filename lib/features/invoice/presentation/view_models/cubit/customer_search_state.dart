part of 'customer_search_cubit.dart';

@immutable
sealed class CustomerSearchState {}

final class CustomerSearchInitial extends CustomerSearchState {}

final class CustomerSearchLoading extends CustomerSearchState {}

final class CustomerSearchSuccess extends CustomerSearchState {
  final List<CustomerEntity> customers;

  CustomerSearchSuccess({required this.customers});
}

final class CustomerSearchError extends CustomerSearchState {
  final String message;

  CustomerSearchError({required this.message});
}
