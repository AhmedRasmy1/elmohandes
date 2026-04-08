import 'package:elmohandes/features/invoice/data/models/all_inovices/customer.dart';

class CustomerEntity {
  final String name;
  final String phone;
  final double totalPaid;
  final double totalAmount;
  final double totalRemaining;
  final List<Invoices> invoices;

  CustomerEntity(
      {required this.name,
      required this.phone,
      required this.totalPaid,
      required this.totalAmount,
      required this.totalRemaining,
      required this.invoices});
}
