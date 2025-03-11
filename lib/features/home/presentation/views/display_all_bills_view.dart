import 'package:awesome_dialog/awesome_dialog.dart';
import 'home_page_view.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';
import '../viewmodels/delete_bills/delete_all_bills_cubit.dart';
import '../viewmodels/display_bills/bills_cubit.dart';
import 'bill_history_details_view.dart';
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
  late DeleteAllBillsCubit deleteAllBillsCubit;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<BillsCubit>();
    deleteAllBillsCubit = getIt.get<DeleteAllBillsCubit>();

    String? token = CacheService.getData(key: CacheConstants.userToken);
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      isAdmin = decodedToken['roles']?.contains("Admin") ?? false;
    }

    viewModel.getAllBills();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => viewModel),
        BlocProvider(create: (context) => deleteAllBillsCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const ProductsPage();
              }));
            },
          ),
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
                  if (value.isNotEmpty) {
                    viewModel.searchBillById(value);
                  } else {
                    viewModel.getAllBills();
                  }
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

                      final filteredInvoices = isAdmin
                          ? invoices
                          : invoices
                              .where((invoice) =>
                                  invoice.id.toString() ==
                                  searchController.text.trim())
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
                                  CacheService.setData(
                                      key: CacheConstants.billId,
                                      value: bill.id);
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
              if (isAdmin)
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
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.scale,
                          title: 'تحذير ',
                          desc:
                              'هل أنت متأكد أنك تريد حذف جميع الفواتير؟\nلن تتمكن من استعادتها بعد الحذف!',
                          btnCancelText: 'إلغاء ',
                          btnCancelOnPress: () {},
                          btnCancelColor: Colors.blue,
                          btnOkText: 'حذف ',
                          btnOkOnPress: () {
                            deleteAllBillsCubit.deleteAllBills().then((_) {
                              viewModel.getAllBills();
                            });
                          },
                          btnOkColor: Colors.red,
                          dismissOnTouchOutside: false,
                          padding: const EdgeInsets.all(20),
                          buttonsBorderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          width: MediaQuery.of(context).size.width *
                              (MediaQuery.of(context).size.width < 600
                                  ? 0.9
                                  : 0.8),
                        ).show();
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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text('رقم الفاتورة: $invoiceId'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('العميل: $customerName'),
            Text('المنتج: $productName'),
            Text('التاريخ: $date'),
            Text('الإجمالي: $totalPrice ج.م'),
          ],
        ),
      ),
    );
  }
}
