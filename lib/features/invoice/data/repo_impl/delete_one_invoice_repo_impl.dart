import '../data_sources/delete_one_invoice_data_sources.dart';
import '../../domain/repo/delete_one_invoice_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeleteOneInvoiceRepo)
class DeleteOneInvoiceRepoImpl implements DeleteOneInvoiceRepo {
  DeleteOneInvoiceDataSources deleteOneInvoiceDataSources;
  DeleteOneInvoiceRepoImpl({required this.deleteOneInvoiceDataSources});
  @override
  Future deleteOneInvoice({required String id, required String token}) {
    return deleteOneInvoiceDataSources.deleteOneInvoice(id: id, token: token);
  }
}
