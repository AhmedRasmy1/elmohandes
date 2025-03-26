import 'package:dio/dio.dart';
import 'package:elmohandes/features/invoice/data/models/preview_invoice/preview_invoice.dart';
import 'package:elmohandes/features/invoice/data/models/today_info/today_sales_info_model.dart';
import 'package:elmohandes/features/invoice/data/models/total_sales/total_sales_model.dart';
import '../../../features/cart/data/models/cart_details/cart_details.dart';
import '../../../features/invoice/data/models/all_inovices/all_inovices.dart';
import '../../../features/orders/data/models/add_invoice/add_invoice.dart';
import '../../../features/home/data/models/update_product_model.dart';
import '../../../features/home/data/models/add_product_model.dart';
import '../../../features/home/data/models/products_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../features/auth/data/models/auth_model.dart';
import '../api_constants.dart';
part 'api_manager.g.dart';

@injectable
@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @FactoryMethod()
  factory ApiService(
    Dio dio,
  ) = _ApiService;

  @POST(ApiConstants.login)
  Future<Login> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @GET(ApiConstants.allProducts)
  Future<List<ProductsModel>> getAllProducts();

  @POST(ApiConstants.addProduct)
  @MultiPart()
  Future<AddProductModel> addProduct(
    @Body() FormData formData,
  );

  @PUT('${ApiConstants.updateProduct}/{id}')
  Future<UpdateProduct> updateProduct(
    @Path('id') int id,
    @Field('name') String name,
    @Field('countryOfOrigin') String countryOfOrigin,
    @Field('price') num price,
    @Field('quantity') num quantity,
    @Field('discount') num discount,
  );

  @DELETE('${ApiConstants.deleteOneProduct}/{id}')
  Future deleteProduct(
    @Path('id') int id,
  );

  @POST('${ApiConstants.addProductToCart}/{id}')
  Future addProductToCart(
    @Path('id') int id,
    @Header('Authorization') String token,
    @Field('quantity') int quantity,
  );

  @GET(ApiConstants.cartDetails)
  Future<List<CartDetails>> getCartDetails(
    @Header('Authorization') String token,
  );

  @DELETE('${ApiConstants.deleteProductFromCart}/{id}')
  Future deleteProductFromCart(
    @Path('id') int id,
    @Header('Authorization') String token,
  );

  @POST(ApiConstants.addInvoice)
  Future<AddInvoice> addInvoice(
    @Header('Authorization') String token,
    @Field('customerName') String customerName,
    @Field('customerPhone') String customerPhone,
    @Field('payType') String payType,
  );

  @GET(ApiConstants.allInvoices)
  Future<List<AllInovices>> getAllInvoices(
    @Header('Authorization') String token,
  );

  @DELETE('${ApiConstants.deleteOneInvoice}/{id}')
  Future deleteOneInvoice(
    @Path('id') String id,
    @Header('Authorization') String token,
  );

  @DELETE(ApiConstants.deleteAllInvoices)
  Future deleteAllInvoices(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.totalSales)
  Future<TotalSalesModel> getTotalSales(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.totalSalesByDate)
  Future<TodaySalesInfoModel> getTotalSalesByDate(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.invoicePreview)
  Future<PreviewInvoice> getInvoicePreview(
    @Header('Authorization') String token,
  );
}
