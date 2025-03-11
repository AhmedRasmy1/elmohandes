import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../../../core/common/api_result.dart';
import '../../../domain/entities/update_product_entity.dart';
import '../../../domain/use_case/update_product_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'update_products_state.dart';

@injectable
class UpdateProductsCubit extends Cubit<UpdateProductsState> {
  final UpdateProductUseCase _updateProductUseCase;
  UpdateProductsCubit(this._updateProductUseCase)
      : super(UpdateProductsInitial());

  Future<void> updateProduct(
      {required int id,
      required String name,
      required String countryOfOrigin,
      required num price,
      required num quantity,
      required num discount}) async {
    emit(UpdateProductsLoading());
    final result = await _updateProductUseCase.updateProduct(
        id: id,
        name: name,
        countryOfOrigin: countryOfOrigin,
        price: price,
        quantity: quantity,
        discount: discount);
    switch (result) {
      case Success<UpdateProductEntity>():
        emit(UpdateProductsSuccess(result.data));
        log('result.data = ${result.data}');
        break;
      case Fail<UpdateProductEntity>():
        emit(UpdateProductsFailure('Error'));
        log('Error');
        break;
    }
  }
}
