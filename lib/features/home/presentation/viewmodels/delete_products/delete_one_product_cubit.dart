import 'package:bloc/bloc.dart';
import '../../../../../core/common/api_result.dart';
import '../../../domain/use_case/delete_product_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'delete_one_product_state.dart';

@injectable
class DeleteOneProductCubit extends Cubit<DeleteOneProductState> {
  final DeleteProductUseCase _deleteProductUseCase;
  DeleteOneProductCubit(this._deleteProductUseCase)
      : super(DeleteOneProductInitial());

  Future<void> deleteProduct(int id) async {
    emit(DeleteOneProductLoading());
    final result = await _deleteProductUseCase.deleteProduct(id);

    switch (result) {
      case Success<String>():
        emit(DeleteOneProductSuccess(result.data));
        break;
      case Fail<String>():
        emit(DeleteOneProductFailure("Error"));
        break;
    }
  }
}
