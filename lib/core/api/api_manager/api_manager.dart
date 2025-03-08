import 'package:dio/dio.dart';
import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/home/data/models/add_bill_model.dart';
import 'package:elmohandes/features/home/data/models/bills_model.dart';
import 'package:elmohandes/features/home/data/models/update_product_model.dart';
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
  factory ApiService(Dio dio) = _ApiService;

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

  @POST('${ApiConstants.addBill}/{id}')
  Future<AddBillModel> addBill(
    @Path('id') int id,
    @Header('Authorization') String token,
    @Field('customerName') String customerName,
    @Field('customerPhone') String customerPhone,
    @Field('payType') String payType,
    @Field('amount') num amount,
  );

  @GET(ApiConstants.allBills)
  Future<List<BillsModel>> getAllBills(
    @Header('Authorization') String token,
  );

  @DELETE(ApiConstants.deleteBills)
  Future deleteAllBills(
    @Header('Authorization') String token,
  );

  @DELETE('${ApiConstants.deleteOneBill}/{id}')
  Future deleteOneBill(
    @Path('id') String id,
    @Header('Authorization') String token,
  );
}
