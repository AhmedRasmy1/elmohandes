import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_invoices_entity.dart';

abstract class AllInvoicesDataSources {
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(
      {required String token});
}
