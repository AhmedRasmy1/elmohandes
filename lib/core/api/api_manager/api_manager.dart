import 'package:dio/dio.dart';
import 'package:elmohandes/features/auth/data/models/auth_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

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
}
