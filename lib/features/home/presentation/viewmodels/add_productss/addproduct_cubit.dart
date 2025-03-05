import 'package:bloc/bloc.dart';
import '../../../../../core/common/api_result.dart';
import '../../../domain/entities/add_product_entity.dart';
import '../../../domain/use_case/add_product_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

part 'addproduct_state.dart';

@injectable
class AddproductCubit extends Cubit<AddproductState> {
  final AddProductUseCase _addProductUseCase;
  AddproductCubit(this._addProductUseCase) : super(AddproductInitial());

  Future<void> addProduct({required FormData formData}) async {
    emit(AddproductLoading());
    final result = await _addProductUseCase.addProduct(formData);
    switch (result) {
      case Success<AddProductEntity>():
        emit(AddproductSuccess(result.data));
        break;
      case Fail<AddProductEntity>():
        emit(Addproductfailure('Error'));
        break;
    }
  }
}
