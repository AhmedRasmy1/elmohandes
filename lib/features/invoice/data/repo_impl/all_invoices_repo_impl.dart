import 'package:elmohandes/features/invoice/domain/entities/customer_entity.dart';

import '../../../../core/common/api_result.dart';
import '../data_sources/all_invoices_data_sources.dart';
import '../../domain/entities/all_invoices_entity.dart';
import '../../domain/repo/all_invoices_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AllInvoicesRepo)
class AllInvoicesRepoImpl implements AllInvoicesRepo {
  AllInvoicesDataSources allInvoicesDataSources;
  AllInvoicesRepoImpl(this.allInvoicesDataSources);
  @override
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(String token) {
    return allInvoicesDataSources.getAllInvoices(token: token);
  }
}

//------------------------------------------------------------------------
@Injectable(as: SearchCustomerRepo)
class SearchCustomerRepoImpl implements SearchCustomerRepo {
  SearchCustomerDataSources searchCustomerDataSources;
  SearchCustomerRepoImpl(this.searchCustomerDataSources);
  @override
  Future<Result<List<CustomerEntity>>> searchCustomer(
      {required String token, required String phone}) {
    return searchCustomerDataSources.searchCustomer(token: token, phone: phone);
  }
}
