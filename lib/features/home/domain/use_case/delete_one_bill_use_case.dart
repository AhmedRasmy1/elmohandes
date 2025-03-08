import 'package:elmohandes/features/home/domain/reposatory/delete_one_bill.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteOneBillUseCase {
  final DeleteOneBillRepo deleteOneBillRepo;
  DeleteOneBillUseCase({required this.deleteOneBillRepo});

  Future deleteOneBill(String id, String token) {
    return deleteOneBillRepo.deleteOneBill(id, token);
  }
}
