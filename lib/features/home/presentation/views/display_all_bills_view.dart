import 'package:elmohandes/features/home/presentation/viewmodels/display_bills/bills_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  late BillsCubit viewModel;
  final TextEditingController searchController = TextEditingController();
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<BillsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel..getAllBills(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'عرض الفواتير',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث عن فاتورة برقمها...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  setState(() {
                    searchQuery = value.isNotEmpty ? value : null;
                  });
                },
              ),
              const SizedBox(height: 15),
              Expanded(
                child: BlocBuilder<BillsCubit, BillsState>(
                  builder: (context, state) {
                    if (state is BillsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BillsSuccess) {
                      final invoices = state.bills;

                      final filteredInvoices = searchQuery == null
                          ? invoices
                          : invoices
                              .where((invoice) =>
                                  invoice.id.toString() == searchQuery)
                              .toList();

                      if (filteredInvoices.isEmpty) {
                        return const Center(child: Text('لا توجد فواتير'));
                      }

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount =
                              constraints.maxWidth > 600 ? 3 : 1;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2.5,
                            ),
                            itemCount: filteredInvoices.length,
                            itemBuilder: (context, index) {
                              final bill = filteredInvoices[index];
                              return InvoiceCard(
                                invoiceId: bill.id.toString(),
                                customerName: bill.customerName!,
                                productName: bill.productName!,
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('حدث خطأ ما'));
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // viewModel.deleteAllInvoices();
                },
                child: const Text(
                  'حذف كل الفواتير',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======== تصميم كارت الفاتورة ========
class InvoiceCard extends StatelessWidget {
  final String invoiceId;
  final String customerName;
  final String productName;

  const InvoiceCard({
    super.key,
    required this.invoiceId,
    required this.customerName,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('رقم الفاتورة: $invoiceId',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text('اسم العميل: $customerName'),
          const SizedBox(height: 5),
          Text('اسم المنتج: $productName'),
        ],
      ),
    );
  }
}
