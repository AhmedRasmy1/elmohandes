import 'package:elmohandes/features/invoice/domain/entities/all_customers_entity.dart';
import 'package:elmohandes/features/invoice/domain/entities/customer_entity.dart';

import '../../../../core/common/api_result.dart';
import '../entities/all_invoices_entity.dart';

abstract class AllInvoicesRepo {
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(String token);
}

//------------------------------------------------------------------------
abstract class SearchCustomerRepo {
  Future<Result<List<CustomerEntity>>> searchCustomer({
    required String token,
    required String phone,
  });
}

//------------------------------------------------------------------------
abstract class AllCustomersRepo {
  Future<Result<List<AllCustomersEntity>>> getAllCustomers(
      {required String token});
}
