import 'package:elmohandes/features/home/presentation/viewmodels/display_bills/bills_cubit.dart';
import 'package:elmohandes/features/home/presentation/views/bill_history_details_view.dart';
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
                onChanged: (value) {
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
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InvoiceDetailsPage(
                                        invoiceId: bill.id.toString(),
                                        customerName: bill.customerName!,
                                        productName: bill.productName!,
                                        customerPhone: bill.customerPhone!,
                                        payType: bill.payType!,
                                        price: bill.price!,
                                        discount: bill.discount!,
                                        amount: bill.amount!,
                                        totalPrice: bill.totalPrice!,
                                        createdByName: bill.createdByName!,
                                        createdOn: bill.createdAt!,
                                      ),
                                    ),
                                  );
                                },
                                child: InvoiceCard(
                                  invoiceId: bill.id.toString(),
                                  customerName: bill.customerName!,
                                  productName: bill.productName!,
                                  totalPrice: bill.totalPrice!,
                                  date: bill.createdAt!,
                                ),
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
              LayoutBuilder(
                builder: (context, constraints) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: constraints.maxWidth * 0.3,
                      ),
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
                  );
                },
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
  final String date;
  final num totalPrice;

  const InvoiceCard({
    super.key,
    required this.invoiceId,
    required this.customerName,
    required this.productName,
    required this.date,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = constraints.maxWidth > 600 ? 18 : 14;
        double iconSize = constraints.maxWidth > 600 ? 24 : 20;
        double padding = constraints.maxWidth > 600 ? 15 : 10;

        return SizedBox(
          height: 180, // زودت الطول هنا
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // توزيع متساوي للعناصر
                children: [
                  Text(
                    'رقم الفاتورة: $invoiceId',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue, size: iconSize),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'اسم العميل: $customerName',
                          style: TextStyle(fontSize: fontSize),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.shopping_bag,
                          color: Colors.green, size: iconSize),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'اسم المنتج: $productName',
                          style: TextStyle(fontSize: fontSize),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range,
                          color: Colors.orange, size: iconSize),
                      const SizedBox(width: 5),
                      Text(
                        'تاريخ الفاتورة: $date',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.money, color: Colors.green, size: iconSize),
                      const SizedBox(width: 5),
                      Text(
                        'الإجمالي: $totalPrice ج.م',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
