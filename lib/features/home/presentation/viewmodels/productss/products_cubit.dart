import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/domain/entities/products_entity.dart';
import 'package:elmohandes/features/home/domain/use_case/products_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final ProductsUseCase _productsUseCase;
  ProductsCubit(this._productsUseCase) : super(ProductsInitial());
  Future<void> getAllProducts() async {
    emit(ProductsLoading());
    final result = await _productsUseCase.getAllProducts();
    log('result: $result');
    switch (result) {
      case Success<List<ProductsEntity>>():
        emit(ProductsSuccess(result.data));
        log('result.data: ${result.data}');
        break;
      case Fail<ProductsEntity>():
        emit(ProductsFailure('Error'));
        log('Error');
        break;
    }
  }
}
