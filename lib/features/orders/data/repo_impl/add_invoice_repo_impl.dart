import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/orders/data/data_sources/add_invoice_data_sources.dart';
import 'package:elmohandes/features/orders/domain/entities/add_invoice_entity.dart';
import 'package:elmohandes/features/orders/domain/repo/add_invoice_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddInvoiceRepo)
class AddInvoiceRepoImpl implements AddInvoiceRepo {
  AddInvoiceDataSources addInvoiceDataSources;
  AddInvoiceRepoImpl(this.addInvoiceDataSources);
  @override
  Future<Result<AddInvoiceEntity>> addInvoice(
      {required String token,
      required String customerName,
      required String customerPhone,
      required String payType}) {
    return addInvoiceDataSources.addInvoice(
        token: token,
        customerName: customerName,
        customerPhone: customerPhone,
        payType: payType);
  }
}
