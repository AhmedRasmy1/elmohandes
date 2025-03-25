import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elmohandes/features/invoice/presentation/view_models/cubit/toda_sales_info_cubit.dart';
import 'package:elmohandes/features/invoice/presentation/view_models/cubit/total_sales_cubit.dart';
import '../../../../core/di/di.dart';
import '../../../home/presentation/views/home_page_view.dart';
import '../../domain/entities/all_invoices_entity.dart';
import '../view_models/cubit/delete_all_invoices_cubit.dart';
import '../view_models/cubit/delete_one_invoices_cubit.dart';
import '../view_models/display_all_invoices/all_invoices_cubit.dart';
import 'display_all_invoices_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';

class InvoicesView extends StatefulWidget {
  const InvoicesView({super.key});

  @override
  State<InvoicesView> createState() => _InvoicesViewState();
}

class _InvoicesViewState extends State<InvoicesView> {
  final TextEditingController searchController = TextEditingController();
  late String role;
  late AllInvoicesCubit allInvoicesCubit;
  late DeleteOneInvoicesCubit deleteOneInvoicesCubit;
  late DeleteAllInvoicesCubit deleteAllInvoicesCubit;
  late TotalSalesCubit totalSalesCubit;
  late TodaSalesInfoCubit todaSalesInfoCubit;
  List<AllInvoiceEntity> allInvoices = [];

  @override
  void initState() {
    super.initState();
    role = CacheService.getData(key: CacheConstants.role) ?? "";
    allInvoicesCubit = getIt.get<AllInvoicesCubit>();
    deleteOneInvoicesCubit = getIt.get<DeleteOneInvoicesCubit>();
    deleteAllInvoicesCubit = getIt.get<DeleteAllInvoicesCubit>();
    totalSalesCubit = getIt.get<TotalSalesCubit>();
    todaSalesInfoCubit = getIt.get<TodaSalesInfoCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => allInvoicesCubit..getAllInvoices(),
        ),
        BlocProvider(
          create: (context) => deleteOneInvoicesCubit,
        ),
        BlocProvider(
          create: (context) => deleteAllInvoicesCubit,
        ),
        BlocProvider(
          create: (context) => totalSalesCubit..getTotalSales(),
        ),
        BlocProvider(
          create: (context) => todaSalesInfoCubit..getTotalSalesByDate(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProductsPage()),
              );
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
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                            });
                          },
                        )
                      : null,
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {}); // تحديث الواجهة عند البحث
                },
              ),
              const SizedBox(height: 15),
              LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;
                  return isMobile
                      ? Column(
                          children: [
                            BlocBuilder<TotalSalesCubit, TotalSalesState>(
                              builder: (context, state) {
                                if (state is TotalSalesSuccess) {
                                  if (role == "Admin") {
                                    var data = state.totalSalesEntity;
                                    log('Total Sales: ${data.totalSales}');
                                    return Text(
                                      'إجمالي المبيعات: ${data.totalSales} ج.م',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            BlocBuilder<AllInvoicesCubit, AllInvoicesState>(
                              builder: (context, state) {
                                if (state is AllInvoicesSuccess) {
                                  if (role == "Admin") {
                                    return Text(
                                      'عدد الفواتير: ${state.allInvoices.length}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            const Divider(),
                            BlocBuilder<TodaSalesInfoCubit, TodaSalesInfoState>(
                                builder: (context, state) {
                              if (state is TodaSalesInfoSuccess) {
                                var data = state.todaySalesInfoEntity;
                                if (role == "Admin") {
                                  return Column(
                                    children: [
                                      Text(
                                        'مبيعات اليوم: ${data.totalSales} ج.م',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'عدد الفواتير: ${data.invoiceCount}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  );
                                }
                              }
                              return const SizedBox.shrink();
                            }),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<TotalSalesCubit, TotalSalesState>(
                                  builder: (context, state) {
                                    if (state is TotalSalesSuccess) {
                                      if (role == "Admin") {
                                        var data = state.totalSalesEntity;
                                        log('Total Sales: ${data.totalSales}');
                                        return Text(
                                          'إجمالي المبيعات: ${data.totalSales} ج.م',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                                BlocBuilder<AllInvoicesCubit, AllInvoicesState>(
                                  builder: (context, state) {
                                    if (state is AllInvoicesSuccess) {
                                      if (role == "Admin") {
                                        return Text(
                                          'عدد الفواتير الاجمالي: ${state.allInvoices.length}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<TodaSalesInfoCubit,
                                    TodaSalesInfoState>(
                                  builder: (context, state) {
                                    if (state is TodaSalesInfoSuccess) {
                                      var data = state.todaySalesInfoEntity;
                                      if (role == "Admin") {
                                        return Column(
                                          children: [
                                            Text(
                                              'مبيعات اليوم: ${data.totalSales} ج.م',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'عدد فواتير اليوم: ${data.invoiceCount}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                },
              ),
              const SizedBox(height: 15),
              Expanded(
                child: BlocBuilder<AllInvoicesCubit, AllInvoicesState>(
                  builder: (context, state) {
                    if (state is AllInvoicesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AllInvoicesFailure) {
                      return const Center(
                          child: Text('حدث خطأ أثناء تحميل الفواتير'));
                    } else if (state is AllInvoicesSuccess) {
                      allInvoices = state.allInvoices;
                      String searchQuery = searchController.text.trim();
                      List<AllInvoiceEntity> displayedInvoices = [];

                      if (role == "Admin") {
                        displayedInvoices = searchQuery.isNotEmpty
                            ? allInvoices
                                .where((invoice) =>
                                    invoice.invoiceNumber == searchQuery)
                                .toList()
                            : allInvoices;
                      } else {
                        if (searchQuery.isNotEmpty) {
                          displayedInvoices = allInvoices
                              .where((invoice) =>
                                  invoice.invoiceNumber == searchQuery)
                              .toList();
                        }
                      }

                      return displayedInvoices.isNotEmpty
                          ? GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).size.width > 600
                                        ? 4
                                        : 1,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: displayedInvoices.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InvoicePageDetails(
                                          invoiceData: displayedInvoices[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: InvoiceCard(
                                      invoice: displayedInvoices[index],
                                      deleteOneInvoicesCubit:
                                          deleteOneInvoicesCubit,
                                      deleteAllInvoicesCubit:
                                          deleteAllInvoicesCubit,
                                      allInvoicesCubit: allInvoicesCubit,
                                      totalSalesCubit: totalSalesCubit,
                                      todaSalesInfoCubit: todaSalesInfoCubit),
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                'لا توجد فواتير',
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                    }
                    return const Center(child: Text('لا توجد بيانات للعرض'));
                  },
                ),
              ),
              const SizedBox(height: 20),
              if (role == "Admin")
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
                          title: 'تحذير',
                          desc:
                              'هل أنت متأكد أنك تريد حذف جميع الفواتير؟\nلن تتمكن من استعادتها بعد الحذف!',
                          btnCancelText: 'إلغاء',
                          btnCancelOnPress: () {},
                          btnCancelColor: Colors.blue,
                          btnOkText: 'حذف',
                          btnOkOnPress: () {
                            if (allInvoices.isNotEmpty) {
                              deleteAllInvoicesCubit
                                  .deleteAllInvoices()
                                  .then((value) {
                                allInvoicesCubit.getAllInvoices();
                                totalSalesCubit.getTotalSales();
                                todaSalesInfoCubit.getTotalSalesByDate();
                              });
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.scale,
                                title: 'تنبيه',
                                desc: 'لا توجد فواتير لحذفها.',
                                btnOkText: 'حسناً',
                                btnOkOnPress: () {},
                                btnOkColor: Colors.blue,
                                dismissOnTouchOutside: true,
                                padding: const EdgeInsets.all(20),
                                buttonsBorderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                width: MediaQuery.of(context).size.width *
                                    (MediaQuery.of(context).size.width < 600
                                        ? 0.9
                                        : 0.8),
                              ).show();
                            }
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

class InvoiceCard extends StatelessWidget {
  final AllInvoiceEntity invoice;
  final DeleteOneInvoicesCubit deleteOneInvoicesCubit;
  final AllInvoicesCubit allInvoicesCubit;
  final TotalSalesCubit totalSalesCubit;
  final DeleteAllInvoicesCubit deleteAllInvoicesCubit;
  final TodaSalesInfoCubit todaSalesInfoCubit;

  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.deleteOneInvoicesCubit,
    required this.allInvoicesCubit,
    required this.deleteAllInvoicesCubit,
    required this.totalSalesCubit,
    required this.todaSalesInfoCubit,
  });

  @override
  Widget build(BuildContext context) {
    // تنسيق التاريخ
    DateTime createdAt;
    if (invoice.createdAt is String) {
      createdAt =
          DateTime.tryParse(invoice.createdAt!)?.toLocal() ?? DateTime.now();
    } else if (invoice.createdAt is DateTime) {
      createdAt = (invoice.createdAt as DateTime).toLocal();
    } else {
      createdAt = DateTime.now();
    }

    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(createdAt);

    // الحصول على الدور
    String role = CacheService.getData(key: CacheConstants.role) ?? "";

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصف الأول: رقم الفاتورة + أيقونة الحذف للإدمن
            Row(
              children: [
                const Icon(Icons.receipt, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'رقم الفاتورة: ${invoice.invoiceNumber ?? 'غير متوفر'}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (role == "Admin") // إظهار أيقونة الحذف للإدمن فقط
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteDialog(context),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            _buildRow(
              icon: Icons.person,
              iconColor: Colors.green,
              label: 'العميل',
              value: invoice.customerName ?? 'غير متوفر',
            ),
            const SizedBox(height: 8),

            _buildRow(
              icon: Icons.calendar_today,
              iconColor: Colors.orange,
              label: 'التاريخ',
              value: formattedDate,
            ),
            const SizedBox(height: 8),

            _buildRow(
              icon: Icons.attach_money,
              iconColor: Colors.red,
              label: 'الإجمالي',
              value: '${invoice.invoiceTotalPrice ?? 0} ج.م',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: $value',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: 'تحذير',
      desc: 'هل أنت متأكد أنك تريد حذف هذه الفاتورة؟',
      btnCancelText: 'إلغاء',
      btnCancelOnPress: () {},
      btnCancelColor: Colors.blue,
      btnOkText: 'حذف',
      btnOkOnPress: () {
        deleteOneInvoicesCubit
            .deleteOneInvoice(id: invoice.invoiceNumber!)
            .then((value) {
          allInvoicesCubit.getAllInvoices();
          totalSalesCubit.getTotalSales();
          todaSalesInfoCubit.getTotalSalesByDate();
        });
      },
      btnOkColor: Colors.red,
      dismissOnTouchOutside: false,
      padding: const EdgeInsets.all(20),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(10)),
      width: MediaQuery.of(context).size.width *
          (MediaQuery.of(context).size.width < 600 ? 0.9 : 0.8),
    ).show();
  }
}
