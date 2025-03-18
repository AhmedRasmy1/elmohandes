import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_invoices_entity.dart';

abstract class AllInvoicesRepo {
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(String token);
}
