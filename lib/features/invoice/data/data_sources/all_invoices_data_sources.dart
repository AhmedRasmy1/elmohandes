import 'package:elmohandes/features/invoice/domain/entities/customer_entity.dart';

import '../../../../core/common/api_result.dart';
import '../../domain/entities/all_invoices_entity.dart';

abstract class AllInvoicesDataSources {
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(
      {required String token});
}

//--------------------------------------------------------------
abstract class SearchCustomerDataSources {
  Future<Result<List<CustomerEntity>>> searchCustomer({
    required String token,
    required String phone,
  });
}
