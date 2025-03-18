import '../../../../core/common/api_result.dart';
import '../../domain/entities/all_invoices_entity.dart';

abstract class AllInvoicesDataSources {
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(
      {required String token});
}
