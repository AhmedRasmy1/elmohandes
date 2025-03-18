import 'package:elmohandes/features/invoice/data/data_sources/delete_all_invoices_data_sources.dart';
import 'package:elmohandes/features/invoice/domain/repo/delete_all_invoices_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteAllInvoicesRepo)
class DeleteAllInvoicesRepoImpl implements DeleteAllInvoicesRepo {
  DeleteAllInvoicesDataSources deleteAllInvoicesDataSources;
  DeleteAllInvoicesRepoImpl({required this.deleteAllInvoicesDataSources});
  @override
  Future deleteAllInvoices({required String token}) {
    return deleteAllInvoicesDataSources.deleteAllInvoices(token: token);
  }
}
