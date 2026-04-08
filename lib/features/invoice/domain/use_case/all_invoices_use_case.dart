import 'package:elmohandes/features/invoice/domain/entities/customer_entity.dart';

import '../../../../core/common/api_result.dart';
import '../entities/all_invoices_entity.dart';
import '../repo/all_invoices_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllInvoicesUseCase {
  AllInvoicesRepo allInvoicesRepo;
  AllInvoicesUseCase(this.allInvoicesRepo);
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(String token) {
    return allInvoicesRepo.getAllInvoices(token);
  }
}

//------------------------------------------------------------------------
@injectable
class SearchCustomerUseCase {
  SearchCustomerRepo searchCustomerRepo;
  SearchCustomerUseCase(this.searchCustomerRepo);
  Future<Result<List<CustomerEntity>>> searchCustomer(
      {required String token, required String phone}) {
    return searchCustomerRepo.searchCustomer(token: token, phone: phone);
  }
}
