import '../../../../core/common/api_result.dart';
import '../entities/all_invoices_entity.dart';

abstract class AllInvoicesRepo {
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(String token);
}
