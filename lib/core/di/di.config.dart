// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources_impl/data_sources_impl.dart'
    as _i1072;
import '../../features/auth/data/repositores/auth_repo_impl.dart' as _i198;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/presentation/viewmodel/cubit/login_cubit.dart'
    as _i641;
import '../../features/cart/data/data_sources/add_product_to_cart_data_sources.dart'
    as _i550;
import '../../features/cart/data/data_sources_impl/add_product_to_cart_data_sources_impl.dart'
    as _i525;
import '../../features/cart/data/repo_impl/add_product_to_cart_repo_impl.dart'
    as _i454;
import '../../features/cart/domain/repo/add_product_to_cart_repo.dart' as _i522;
import '../../features/cart/domain/use_cases/add_product_to_cart_use_case.dart'
    as _i473;
import '../../features/cart/presentation/view_models/cart_cubit/add_product_to_cart_cubit.dart'
    as _i486;
import '../../features/home/data/data_sources/add_bill_data_sources.dart'
    as _i55;
import '../../features/home/data/data_sources/add_product_data_sources.dart'
    as _i578;
import '../../features/home/data/data_sources/bills_data_sources.dart' as _i996;
import '../../features/home/data/data_sources/delete_all_bills_data_sources.dart'
    as _i309;
import '../../features/home/data/data_sources/delete_one_bill_data_sources.dart'
    as _i610;
import '../../features/home/data/data_sources/delete_product_data_sources.dart'
    as _i157;
import '../../features/home/data/data_sources/products_data_sources.dart'
    as _i920;
import '../../features/home/data/data_sources/update_product_data_sources.dart'
    as _i319;
import '../../features/home/data/data_sources_impl/add_bill_data_sources_impl.dart'
    as _i444;
import '../../features/home/data/data_sources_impl/add_product_data_sources_impl.dart'
    as _i28;
import '../../features/home/data/data_sources_impl/bills_data_sources_impl.dart'
    as _i414;
import '../../features/home/data/data_sources_impl/delete_all_bills_data_sources_impl.dart'
    as _i61;
import '../../features/home/data/data_sources_impl/delete_one_bill_data_sources_imp.dart'
    as _i170;
import '../../features/home/data/data_sources_impl/delete_product_data_sources_impl.dart'
    as _i728;
import '../../features/home/data/data_sources_impl/products_data_sources_impl.dart'
    as _i132;
import '../../features/home/data/data_sources_impl/update_product_data_sources_impl.dart'
    as _i530;
import '../../features/home/data/reposatory/add_bill_repo_impl.dart' as _i907;
import '../../features/home/data/reposatory/add_product_repo_impl.dart'
    as _i135;
import '../../features/home/data/reposatory/bills_repo_impl.dart' as _i585;
import '../../features/home/data/reposatory/delete_bills_repo_impl.dart'
    as _i533;
import '../../features/home/data/reposatory/delete_one_bill_repo_impl.dart'
    as _i833;
import '../../features/home/data/reposatory/delete_product_repo_impl.dart'
    as _i277;
import '../../features/home/data/reposatory/products_repo_impl.dart' as _i59;
import '../../features/home/data/reposatory/update_product_repo_impl.dart'
    as _i594;
import '../../features/home/domain/reposatory/add_bill_repo.dart' as _i545;
import '../../features/home/domain/reposatory/add_product_repo.dart' as _i686;
import '../../features/home/domain/reposatory/bills_repo.dart' as _i496;
import '../../features/home/domain/reposatory/delete_all_bills.dart' as _i657;
import '../../features/home/domain/reposatory/delete_one_bill.dart' as _i988;
import '../../features/home/domain/reposatory/delete_product.dart' as _i758;
import '../../features/home/domain/reposatory/products_repo.dart' as _i322;
import '../../features/home/domain/reposatory/update_product_repo.dart'
    as _i712;
import '../../features/home/domain/use_case/add_bill_use_case.dart' as _i594;
import '../../features/home/domain/use_case/add_product_use_case.dart' as _i170;
import '../../features/home/domain/use_case/bills_use_case.dart' as _i51;
import '../../features/home/domain/use_case/delete_all_bills_use_case.dart'
    as _i176;
import '../../features/home/domain/use_case/delete_one_bill_use_case.dart'
    as _i768;
import '../../features/home/domain/use_case/delete_product_use_case.dart'
    as _i221;
import '../../features/home/domain/use_case/products_use_case.dart' as _i256;
import '../../features/home/domain/use_case/update_product_use_case.dart'
    as _i185;
import '../../features/home/presentation/viewmodels/add_bills/add_bill_cubit.dart'
    as _i755;
import '../../features/home/presentation/viewmodels/add_productss/addproduct_cubit.dart'
    as _i384;
import '../../features/home/presentation/viewmodels/delete_bills/delete_all_bills_cubit.dart'
    as _i682;
import '../../features/home/presentation/viewmodels/delete_one_bill/delete_one_bill_cubit.dart'
    as _i835;
import '../../features/home/presentation/viewmodels/delete_products/delete_one_product_cubit.dart'
    as _i320;
import '../../features/home/presentation/viewmodels/display_bills/bills_cubit.dart'
    as _i667;
import '../../features/home/presentation/viewmodels/productss/products_cubit.dart'
    as _i346;
import '../../features/home/presentation/viewmodels/update_productss/update_products_cubit.dart'
    as _i924;
import '../api/api_manager/api_manager.dart' as _i680;
import '../api/dio_module.dart' as _i784;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.providerDio());
    gh.factory<_i680.ApiService>(() => _i680.ApiService(gh<_i361.Dio>()));
    gh.factory<_i920.ProductsDataSources>(
        () => _i132.ProductsDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i309.DeleteAllBillsDataSources>(
        () => _i61.DeleteAllBillsDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i578.AddProductDataSources>(
        () => _i28.AddProductDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i996.BillsDataSources>(
        () => _i414.BillsDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i322.ProductsRepo>(
        () => _i59.ProductsRepoImpl(gh<_i920.ProductsDataSources>()));
    gh.factory<_i657.DeleteAllBillsRepo>(
        () => _i533.DeleteBillsRepoImpl(gh<_i309.DeleteAllBillsDataSources>()));
    gh.factory<_i157.DeleteProductDataSources>(
        () => _i728.DeleteProductDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i550.AddProductToCartDataSources>(
        () => _i525.AddProductToCartDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i610.DeleteOneBillDataSources>(
        () => _i170.DeleteOneBillDataSourcesImp(gh<_i680.ApiService>()));
    gh.factory<_i496.BillsRepo>(
        () => _i585.BillsRepoImpl(gh<_i996.BillsDataSources>()));
    gh.factory<_i319.UpdateProductDataSources>(
        () => _i530.UpdateProductDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i1072.LoginDataSourceImpl>(
        () => _i1072.LoginDataSourceImpl(gh<_i680.ApiService>()));
    gh.factory<_i55.AddBillDataSources>(
        () => _i444.AddBillDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i686.AddProductRepo>(
        () => _i135.AddProductRepoImpl(gh<_i578.AddProductDataSources>()));
    gh.factory<_i170.AddProductUseCase>(
        () => _i170.AddProductUseCase(gh<_i686.AddProductRepo>()));
    gh.factory<_i988.DeleteOneBillRepo>(() =>
        _i833.DeleteOneBillRepoImpl(gh<_i610.DeleteOneBillDataSources>()));
    gh.factory<_i545.AddBillRepo>(
        () => _i907.AddBillRepoImpl(gh<_i55.AddBillDataSources>()));
    gh.factory<_i522.AddProductToCartRepo>(() => _i454.AddProductToCartRepoImpl(
        gh<_i550.AddProductToCartDataSources>()));
    gh.factory<_i256.ProductsUseCase>(
        () => _i256.ProductsUseCase(gh<_i322.ProductsRepo>()));
    gh.factory<_i768.DeleteOneBillUseCase>(() => _i768.DeleteOneBillUseCase(
        deleteOneBillRepo: gh<_i988.DeleteOneBillRepo>()));
    gh.factory<_i758.DeleteProduct>(() => _i277.DeleteProductRepoImpl(
        deleteProductDataSources: gh<_i157.DeleteProductDataSources>()));
    gh.factory<_i51.BillsUseCase>(
        () => _i51.BillsUseCase(gh<_i496.BillsRepo>()));
    gh.factory<_i346.ProductsCubit>(
        () => _i346.ProductsCubit(gh<_i256.ProductsUseCase>()));
    gh.factory<_i667.BillsCubit>(
        () => _i667.BillsCubit(gh<_i51.BillsUseCase>()));
    gh.factory<_i712.UpdateProductRepo>(() =>
        _i594.UpdateProductRepoImpl(gh<_i319.UpdateProductDataSources>()));
    gh.factory<_i176.DeleteAllBillsUseCase>(
        () => _i176.DeleteAllBillsUseCase(gh<_i657.DeleteAllBillsRepo>()));
    gh.factory<_i723.LoginRepo>(
        () => _i198.LoginRepoImpl(gh<_i1072.LoginDataSourceImpl>()));
    gh.factory<_i682.DeleteAllBillsCubit>(
        () => _i682.DeleteAllBillsCubit(gh<_i176.DeleteAllBillsUseCase>()));
    gh.factory<_i384.AddproductCubit>(
        () => _i384.AddproductCubit(gh<_i170.AddProductUseCase>()));
    gh.factory<_i835.DeleteOneBillCubit>(
        () => _i835.DeleteOneBillCubit(gh<_i768.DeleteOneBillUseCase>()));
    gh.factory<_i185.UpdateProductUseCase>(
        () => _i185.UpdateProductUseCase(gh<_i712.UpdateProductRepo>()));
    gh.factory<_i594.AddBillUseCase>(
        () => _i594.AddBillUseCase(gh<_i545.AddBillRepo>()));
    gh.factory<_i473.AddProductToCartUseCase>(
        () => _i473.AddProductToCartUseCase(gh<_i522.AddProductToCartRepo>()));
    gh.factory<_i924.UpdateProductsCubit>(
        () => _i924.UpdateProductsCubit(gh<_i185.UpdateProductUseCase>()));
    gh.factory<_i755.AddBillCubit>(
        () => _i755.AddBillCubit(gh<_i594.AddBillUseCase>()));
    gh.factory<_i221.DeleteProductUseCase>(
        () => _i221.DeleteProductUseCase(gh<_i758.DeleteProduct>()));
    gh.factory<_i1038.LoginUseCase>(
        () => _i1038.LoginUseCase(gh<_i723.LoginRepo>()));
    gh.factory<_i641.LoginCubit>(
        () => _i641.LoginCubit(gh<_i1038.LoginUseCase>()));
    gh.factory<_i320.DeleteOneProductCubit>(
        () => _i320.DeleteOneProductCubit(gh<_i221.DeleteProductUseCase>()));
    gh.factory<_i486.AddProductToCartCubit>(
        () => _i486.AddProductToCartCubit(gh<_i473.AddProductToCartUseCase>()));
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
