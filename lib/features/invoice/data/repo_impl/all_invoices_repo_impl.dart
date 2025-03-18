import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/data/data_sources/all_invoices_data_sources.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_invoices_entity.dart';
import 'package:elmohandes/features/invoice/domain/repo/all_invoices_repo.dart';
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
