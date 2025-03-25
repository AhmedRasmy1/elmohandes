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
import '../../features/cart/data/data_sources/cart_details_data_sources.dart'
    as _i580;
import '../../features/cart/data/data_sources/delete_product_from_cart_data_sources.dart'
    as _i239;
import '../../features/cart/data/data_sources_impl/add_product_to_cart_data_sources_impl.dart'
    as _i525;
import '../../features/cart/data/data_sources_impl/cart_details_data_sources_impl.dart'
    as _i293;
import '../../features/cart/data/data_sources_impl/delete_product_from_cart_data_sources_impl.dart'
    as _i559;
import '../../features/cart/data/repo_impl/add_product_to_cart_repo_impl.dart'
    as _i454;
import '../../features/cart/data/repo_impl/cart_details_repo_impl.dart'
    as _i800;
import '../../features/cart/data/repo_impl/delete_product_from_cart_repo_impl.dart'
    as _i460;
import '../../features/cart/domain/repo/add_product_to_cart_repo.dart' as _i522;
import '../../features/cart/domain/repo/cart_details_repo.dart' as _i655;
import '../../features/cart/domain/repo/delete_product_from_cart_repo.dart'
    as _i465;
import '../../features/cart/domain/use_cases/add_product_to_cart_use_case.dart'
    as _i473;
import '../../features/cart/domain/use_cases/cart_details_use_case.dart'
    as _i1058;
import '../../features/cart/domain/use_cases/delete_product_from_cart_use_case.dart'
    as _i182;
import '../../features/cart/presentation/view_models/cart_cubit/add_product_to_cart_cubit.dart'
    as _i486;
import '../../features/cart/presentation/view_models/cart_display/cart_details_cubit.dart'
    as _i719;
import '../../features/cart/presentation/view_models/delete_from_cart/delete_cart_product_cubit.dart'
    as _i491;
import '../../features/home/data/data_sources/add_product_data_sources.dart'
    as _i578;
import '../../features/home/data/data_sources/delete_product_data_sources.dart'
    as _i157;
import '../../features/home/data/data_sources/products_data_sources.dart'
    as _i920;
import '../../features/home/data/data_sources/update_product_data_sources.dart'
    as _i319;
import '../../features/home/data/data_sources_impl/add_product_data_sources_impl.dart'
    as _i28;
import '../../features/home/data/data_sources_impl/delete_product_data_sources_impl.dart'
    as _i728;
import '../../features/home/data/data_sources_impl/products_data_sources_impl.dart'
    as _i132;
import '../../features/home/data/data_sources_impl/update_product_data_sources_impl.dart'
    as _i530;
import '../../features/home/data/reposatory/add_product_repo_impl.dart'
    as _i135;
import '../../features/home/data/reposatory/delete_product_repo_impl.dart'
    as _i277;
import '../../features/home/data/reposatory/products_repo_impl.dart' as _i59;
import '../../features/home/data/reposatory/update_product_repo_impl.dart'
    as _i594;
import '../../features/home/domain/reposatory/add_product_repo.dart' as _i686;
import '../../features/home/domain/reposatory/delete_product.dart' as _i758;
import '../../features/home/domain/reposatory/products_repo.dart' as _i322;
import '../../features/home/domain/reposatory/update_product_repo.dart'
    as _i712;
import '../../features/home/domain/use_case/add_product_use_case.dart' as _i170;
import '../../features/home/domain/use_case/delete_product_use_case.dart'
    as _i221;
import '../../features/home/domain/use_case/products_use_case.dart' as _i256;
import '../../features/home/domain/use_case/update_product_use_case.dart'
    as _i185;
import '../../features/home/presentation/viewmodels/add_productss/addproduct_cubit.dart'
    as _i384;
import '../../features/home/presentation/viewmodels/delete_products/delete_one_product_cubit.dart'
    as _i320;
import '../../features/home/presentation/viewmodels/productss/products_cubit.dart'
    as _i346;
import '../../features/home/presentation/viewmodels/update_productss/update_products_cubit.dart'
    as _i924;
import '../../features/invoice/data/data_sources/all_invoices_data_sources.dart'
    as _i209;
import '../../features/invoice/data/data_sources/delete_all_invoices_data_sources.dart'
    as _i365;
import '../../features/invoice/data/data_sources/delete_one_invoice_data_sources.dart'
    as _i470;
import '../../features/invoice/data/data_sources/today_sales_info_data_sources.dart'
    as _i35;
import '../../features/invoice/data/data_sources/total_sales_data_sources.dart'
    as _i503;
import '../../features/invoice/data/data_sources_impl/all_invoices_data_sources_impl.dart'
    as _i816;
import '../../features/invoice/data/data_sources_impl/delete_all_invoices_data_sources_impl.dart'
    as _i183;
import '../../features/invoice/data/data_sources_impl/delete_one_invoice_data_sources_impl.dart'
    as _i1065;
import '../../features/invoice/data/data_sources_impl/today_sales_info_data_sources_impl.dart'
    as _i406;
import '../../features/invoice/data/data_sources_impl/total_sales_data_sources_impl.dart'
    as _i875;
import '../../features/invoice/data/repo_impl/all_invoices_repo_impl.dart'
    as _i451;
import '../../features/invoice/data/repo_impl/delete_all_invoices_repo_impl.dart'
    as _i962;
import '../../features/invoice/data/repo_impl/delete_one_invoice_repo_impl.dart'
    as _i624;
import '../../features/invoice/data/repo_impl/today_sales_info_repo_impl.dart'
    as _i339;
import '../../features/invoice/data/repo_impl/total_sales_repo_impl.dart'
    as _i16;
import '../../features/invoice/domain/repo/all_invoices_repo.dart' as _i1044;
import '../../features/invoice/domain/repo/delete_all_invoices_repo.dart'
    as _i219;
import '../../features/invoice/domain/repo/delete_one_invoice_repo.dart'
    as _i106;
import '../../features/invoice/domain/repo/today_sales_info_repo.dart' as _i318;
import '../../features/invoice/domain/repo/total_sales_repo.dart' as _i703;
import '../../features/invoice/domain/use_case/all_invoices_use_case.dart'
    as _i1003;
import '../../features/invoice/domain/use_case/delete_all_invoices_use_case.dart'
    as _i127;
import '../../features/invoice/domain/use_case/delete_one_invoices_use_case.dart'
    as _i525;
import '../../features/invoice/domain/use_case/today_sales_info_use_case.dart'
    as _i269;
import '../../features/invoice/domain/use_case/total_sales_use_case.dart'
    as _i790;
import '../../features/invoice/presentation/view_models/cubit/delete_all_invoices_cubit.dart'
    as _i64;
import '../../features/invoice/presentation/view_models/cubit/delete_one_invoices_cubit.dart'
    as _i630;
import '../../features/invoice/presentation/view_models/cubit/toda_sales_info_cubit.dart'
    as _i12;
import '../../features/invoice/presentation/view_models/cubit/total_sales_cubit.dart'
    as _i887;
import '../../features/invoice/presentation/view_models/display_all_invoices/all_invoices_cubit.dart'
    as _i165;
import '../../features/orders/data/data_sources/add_invoice_data_sources.dart'
    as _i120;
import '../../features/orders/data/data_sources_impl/add_invoice_data_sources_impl.dart'
    as _i37;
import '../../features/orders/data/repo_impl/add_invoice_repo_impl.dart'
    as _i121;
import '../../features/orders/domain/repo/add_invoice_repo.dart' as _i482;
import '../../features/orders/domain/use_cases/add_invoice_use_case.dart'
    as _i145;
import '../../features/orders/presentation/view_models/add_invoice_viewmodel/add_invoice_cubit.dart'
    as _i401;
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
    gh.factory<_i239.DeleteProductFromCartDataSources>(() =>
        _i559.DeleteProductFromCartDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i920.ProductsDataSources>(
        () => _i132.ProductsDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i503.TotalSalesDataSources>(
        () => _i875.TotalSalesDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i578.AddProductDataSources>(
        () => _i28.AddProductDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i35.TodaySalesInfoDataSources>(
        () => _i406.TodaySalesInfoDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i703.TotalSalesRepo>(
        () => _i16.TotalSalesRepoImpl(gh<_i503.TotalSalesDataSources>()));
    gh.factory<_i322.ProductsRepo>(
        () => _i59.ProductsRepoImpl(gh<_i920.ProductsDataSources>()));
    gh.factory<_i465.DeleteProductFromCartRepo>(() =>
        _i460.DeleteProductFromCartRepoImpl(
            gh<_i239.DeleteProductFromCartDataSources>()));
    gh.factory<_i790.TotalSalesUseCase>(
        () => _i790.TotalSalesUseCase(gh<_i703.TotalSalesRepo>()));
    gh.factory<_i470.DeleteOneInvoiceDataSources>(() =>
        _i1065.DeleteOneInvoiceDataSourcesImpl(
            apiService: gh<_i680.ApiService>()));
    gh.factory<_i580.CartDetailsDataSources>(
        () => _i293.CartDetailsDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i209.AllInvoicesDataSources>(
        () => _i816.AllInvoicesDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i157.DeleteProductDataSources>(
        () => _i728.DeleteProductDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i550.AddProductToCartDataSources>(
        () => _i525.AddProductToCartDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i319.UpdateProductDataSources>(
        () => _i530.UpdateProductDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i365.DeleteAllInvoicesDataSources>(
        () => _i183.DeleteAllInvoicesDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i1072.LoginDataSourceImpl>(
        () => _i1072.LoginDataSourceImpl(gh<_i680.ApiService>()));
    gh.factory<_i686.AddProductRepo>(
        () => _i135.AddProductRepoImpl(gh<_i578.AddProductDataSources>()));
    gh.factory<_i120.AddInvoiceDataSources>(
        () => _i37.AddInvoiceDataSourcesImpl(gh<_i680.ApiService>()));
    gh.factory<_i106.DeleteOneInvoiceRepo>(() => _i624.DeleteOneInvoiceRepoImpl(
        deleteOneInvoiceDataSources: gh<_i470.DeleteOneInvoiceDataSources>()));
    gh.factory<_i170.AddProductUseCase>(
        () => _i170.AddProductUseCase(gh<_i686.AddProductRepo>()));
    gh.factory<_i318.TodaySalesInfoRepo>(() => _i339.TodaySalesInfoRepoImpl(
        todaySalesInfoDataSources: gh<_i35.TodaySalesInfoDataSources>()));
    gh.factory<_i182.DeleteProductFromCartUseCase>(() =>
        _i182.DeleteProductFromCartUseCase(
            gh<_i465.DeleteProductFromCartRepo>()));
    gh.factory<_i525.DeleteOneInvoicesUseCase>(() =>
        _i525.DeleteOneInvoicesUseCase(
            deleteOneInvoiceRepo: gh<_i106.DeleteOneInvoiceRepo>()));
    gh.factory<_i522.AddProductToCartRepo>(() => _i454.AddProductToCartRepoImpl(
        gh<_i550.AddProductToCartDataSources>()));
    gh.factory<_i1044.AllInvoicesRepo>(
        () => _i451.AllInvoicesRepoImpl(gh<_i209.AllInvoicesDataSources>()));
    gh.factory<_i887.TotalSalesCubit>(
        () => _i887.TotalSalesCubit(gh<_i790.TotalSalesUseCase>()));
    gh.factory<_i256.ProductsUseCase>(
        () => _i256.ProductsUseCase(gh<_i322.ProductsRepo>()));
    gh.factory<_i219.DeleteAllInvoicesRepo>(() =>
        _i962.DeleteAllInvoicesRepoImpl(
            deleteAllInvoicesDataSources:
                gh<_i365.DeleteAllInvoicesDataSources>()));
    gh.factory<_i1003.AllInvoicesUseCase>(
        () => _i1003.AllInvoicesUseCase(gh<_i1044.AllInvoicesRepo>()));
    gh.factory<_i269.TodaySalesInfoUseCase>(
        () => _i269.TodaySalesInfoUseCase(gh<_i318.TodaySalesInfoRepo>()));
    gh.factory<_i165.AllInvoicesCubit>(
        () => _i165.AllInvoicesCubit(gh<_i1003.AllInvoicesUseCase>()));
    gh.factory<_i758.DeleteProduct>(() => _i277.DeleteProductRepoImpl(
        deleteProductDataSources: gh<_i157.DeleteProductDataSources>()));
    gh.factory<_i346.ProductsCubit>(
        () => _i346.ProductsCubit(gh<_i256.ProductsUseCase>()));
    gh.factory<_i12.TodaSalesInfoCubit>(
        () => _i12.TodaSalesInfoCubit(gh<_i269.TodaySalesInfoUseCase>()));
    gh.factory<_i655.CartDetailRepo>(
        () => _i800.CartDetailsRepoImpl(gh<_i580.CartDetailsDataSources>()));
    gh.factory<_i491.DeleteCartProductCubit>(() =>
        _i491.DeleteCartProductCubit(gh<_i182.DeleteProductFromCartUseCase>()));
    gh.factory<_i712.UpdateProductRepo>(() =>
        _i594.UpdateProductRepoImpl(gh<_i319.UpdateProductDataSources>()));
    gh.factory<_i723.LoginRepo>(
        () => _i198.LoginRepoImpl(gh<_i1072.LoginDataSourceImpl>()));
    gh.factory<_i482.AddInvoiceRepo>(
        () => _i121.AddInvoiceRepoImpl(gh<_i120.AddInvoiceDataSources>()));
    gh.factory<_i384.AddproductCubit>(
        () => _i384.AddproductCubit(gh<_i170.AddProductUseCase>()));
    gh.factory<_i630.DeleteOneInvoicesCubit>(() =>
        _i630.DeleteOneInvoicesCubit(gh<_i525.DeleteOneInvoicesUseCase>()));
    gh.factory<_i145.AddInvoiceUseCase>(
        () => _i145.AddInvoiceUseCase(gh<_i482.AddInvoiceRepo>()));
    gh.factory<_i185.UpdateProductUseCase>(
        () => _i185.UpdateProductUseCase(gh<_i712.UpdateProductRepo>()));
    gh.factory<_i473.AddProductToCartUseCase>(
        () => _i473.AddProductToCartUseCase(gh<_i522.AddProductToCartRepo>()));
    gh.factory<_i127.DeleteAllInvoicesUseCase>(() =>
        _i127.DeleteAllInvoicesUseCase(
            deleteAllInvoicesRepo: gh<_i219.DeleteAllInvoicesRepo>()));
    gh.factory<_i924.UpdateProductsCubit>(
        () => _i924.UpdateProductsCubit(gh<_i185.UpdateProductUseCase>()));
    gh.factory<_i221.DeleteProductUseCase>(
        () => _i221.DeleteProductUseCase(gh<_i758.DeleteProduct>()));
    gh.factory<_i1038.LoginUseCase>(
        () => _i1038.LoginUseCase(gh<_i723.LoginRepo>()));
    gh.factory<_i1058.CartDetailsUseCase>(
        () => _i1058.CartDetailsUseCase(gh<_i655.CartDetailRepo>()));
    gh.factory<_i641.LoginCubit>(
        () => _i641.LoginCubit(gh<_i1038.LoginUseCase>()));
    gh.factory<_i320.DeleteOneProductCubit>(
        () => _i320.DeleteOneProductCubit(gh<_i221.DeleteProductUseCase>()));
    gh.factory<_i486.AddProductToCartCubit>(
        () => _i486.AddProductToCartCubit(gh<_i473.AddProductToCartUseCase>()));
    gh.factory<_i401.AddInvoiceCubit>(
        () => _i401.AddInvoiceCubit(gh<_i145.AddInvoiceUseCase>()));
    gh.factory<_i64.DeleteAllInvoicesCubit>(() =>
        _i64.DeleteAllInvoicesCubit(gh<_i127.DeleteAllInvoicesUseCase>()));
    gh.factory<_i719.CartDetailsCubit>(
        () => _i719.CartDetailsCubit(gh<_i1058.CartDetailsUseCase>()));
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
