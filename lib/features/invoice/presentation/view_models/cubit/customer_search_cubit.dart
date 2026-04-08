import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/invoice/domain/entities/customer_entity.dart';
import 'package:elmohandes/features/invoice/domain/use_case/all_invoices_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'customer_search_state.dart';

@injectable
class CustomerSearchCubit extends Cubit<CustomerSearchState> {
  final SearchCustomerUseCase searchCustomerUseCase;
  CustomerSearchCubit(this.searchCustomerUseCase)
      : super(CustomerSearchInitial());

  Future<void> searchCustomer(
      {required String token, required String phone}) async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(CustomerSearchLoading());
    final result =
        await searchCustomerUseCase.searchCustomer(token: token, phone: phone);
    switch (result) {
      case Success<List<CustomerEntity>>():
        emit(CustomerSearchSuccess(customers: result.data));
        break;
      case Fail<List<CustomerEntity>>():
        emit(CustomerSearchError(message: "لا يوجد عميل بهذا الرقم"));
        break;
    }
  }

  // ── بترجّع الشاشة لحالتها الأولى لما المستخدم يضغط Clear ──
  void reset() => emit(CustomerSearchInitial());
}
