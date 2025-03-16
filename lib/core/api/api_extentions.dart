import 'dart:async';
import 'dart:io';

import '../common/api_result.dart';
import '../common/custom_exception.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return Success(result);
  } on TimeoutException catch (_) {
    return Fail(NoInternetError());
    // } on DioException catch (ex) {
    //   print(ex.response?.data['message']);
    //   if (ex.response != null) {
    //     return Fail(ServerError(
    //       ex.response?.statusCode,
    //       ex.response?.data['message'] ?? "Unexpected error",
    //     ));
    //   } else {
    //     return Fail(DioHttpException(ex));
    //   }
  } on IOException catch (_) {
    return Fail(NoInternetError());
  } on Exception catch (ex) {
    return Fail(ex);
  }
}
