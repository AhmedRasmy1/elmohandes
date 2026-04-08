import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_customers_entity.dart';
import 'package:elmohandes/features/invoice/domain/use_case/all_invoices_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'all_cutsomer_state.dart';

@injectable
class AllCutsomerCubit extends Cubit<AllCutsomerState> {
  final AllCustomersUseCase allCustomersUseCase;
  AllCutsomerCubit(this.allCustomersUseCase) : super(AllCutsomerInitial());
  Future<void> getAllCoustomers() async {
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken)}';
    emit(AllCutsomerLoaded());
    final result = await allCustomersUseCase.getAllCustomers(token: token);
    switch (result) {
      case Success<List<AllCustomersEntity>>():
        emit(AllCutsomerSuccess(result.data));
        break;
      case Fail<List<AllCustomersEntity>>():
        emit(AllCutsomerError('Error'));
        break;
    }
  }
}
