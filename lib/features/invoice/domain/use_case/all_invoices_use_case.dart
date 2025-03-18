import 'package:elmohandes/core/common/api_result.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_invoices_entity.dart';
import 'package:elmohandes/features/invoice/domain/repo/all_invoices_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllInvoicesUseCase {
  AllInvoicesRepo allInvoicesRepo;
  AllInvoicesUseCase(this.allInvoicesRepo);
  Future<Result<List<AllInvoiceEntity>>> getAllInvoices(String token) {
    return allInvoicesRepo.getAllInvoices(token);
  }
}
