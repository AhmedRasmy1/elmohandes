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

//--------------------------------------------------------------
@Injectable(as: PayFullRepo)
class PayFullRepoImpl implements PayFullRepo {
  PayFullDataSources payFullDataSources;
  PayFullRepoImpl({required this.payFullDataSources});
  @override
  Future payFull({required String id, required String token}) {
    return payFullDataSources.payFull(id: id, token: token);
  }
}

//--------------------------------------------------------------
@Injectable(as: PayPartialRepo)
class PayPartialRepoImpl implements PayPartialRepo {
  PayPartialDataSources payPartialDataSources;
  PayPartialRepoImpl({required this.payPartialDataSources});
  @override
  Future payPartial(
      {required String id, required String token, required double amount}) {
    return payPartialDataSources.payPartial(
        id: id, token: token, amount: amount);
  }
}
