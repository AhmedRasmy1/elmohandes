import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elmohandes/core/di/di.dart';
import 'package:elmohandes/features/home/presentation/views/home_page_view.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_invoices_entity.dart';
import 'package:elmohandes/features/invoice/presentation/view_models/cubit/delete_all_invoices_cubit.dart';
import 'package:elmohandes/features/invoice/presentation/view_models/cubit/delete_one_invoices_cubit.dart';
import 'package:elmohandes/features/invoice/presentation/view_models/display_all_invoices/all_invoices_cubit.dart';
import 'package:elmohandes/features/invoice/presentation/views/display_all_invoices_details.dart';
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
  List<AllInvoiceEntity> allInvoices = [];

  @override
  void initState() {
    super.initState();
    role = CacheService.getData(key: CacheConstants.role) ?? "";
    allInvoicesCubit = getIt.get<AllInvoicesCubit>();
    deleteOneInvoicesCubit = getIt.get<DeleteOneInvoicesCubit>();
    deleteAllInvoicesCubit = getIt.get<DeleteAllInvoicesCubit>();
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
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {}); // تحديث واجهة البحث
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

                      // لو Admin يعرض كل الفواتير
                      if (role == "Admin") {
                        return allInvoices.isNotEmpty
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
                                itemCount: allInvoices.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InvoicePageDetails(
                                            invoiceData: allInvoices[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: InvoiceCard(
                                        invoice: allInvoices[index],
                                        deleteOneInvoicesCubit:
                                            deleteOneInvoicesCubit,
                                        deleteAllInvoicesCubit:
                                            deleteAllInvoicesCubit,
                                        allInvoicesCubit: allInvoicesCubit),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('لا توجد فواتير متاحة.'));
                      }

                      // لو مش Admin يظهر فقط الفاتورة اللي بيبحث عنها
                      String searchQuery = searchController.text.trim();
                      if (searchQuery.isEmpty) {
                        return const Center(
                          child: Text(
                            'من فضلك أدخل رقم الفاتورة للبحث.',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      final filteredInvoices = allInvoices
                          .where(
                              (invoice) => invoice.invoiceNumber == searchQuery)
                          .toList();

                      return filteredInvoices.isNotEmpty
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
                              itemCount: filteredInvoices.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InvoicePageDetails(
                                          invoiceData: filteredInvoices[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: InvoiceCard(
                                      invoice: filteredInvoices[index],
                                      deleteOneInvoicesCubit:
                                          deleteOneInvoicesCubit,
                                      deleteAllInvoicesCubit:
                                          deleteAllInvoicesCubit,
                                      allInvoicesCubit: allInvoicesCubit),
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                'لم يتم العثور على فاتورة بهذا الرقم.',
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
                            deleteAllInvoicesCubit.deleteAllInvoices().then(
                                (value) => allInvoicesCubit.getAllInvoices());
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
  final DeleteAllInvoicesCubit deleteAllInvoicesCubit;
  final AllInvoicesCubit allInvoicesCubit;

  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.deleteOneInvoicesCubit,
    required this.deleteAllInvoicesCubit,
    required this.allInvoicesCubit,
  });

  @override
  Widget build(BuildContext context) {
    // Format the date
    String formattedDate = "غير متوفر";
    if (invoice.createdAt != null && invoice.createdAt!.isNotEmpty) {
      DateTime? parsedDate = DateTime.tryParse(invoice.createdAt!);
      if (parsedDate != null) {
        formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
      }
    }

    // Get the role from cache
    String role = CacheService.getData(key: CacheConstants.role) ?? "";

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(
              context,
              icon: Icons.receipt,
              iconColor: Colors.blue,
              label: 'رقم الفاتورة',
              value: invoice.invoiceNumber ?? 'غير متوفر',
            ),
            const SizedBox(height: 8),
            _buildRow(
              context,
              icon: Icons.person,
              iconColor: Colors.green,
              label: 'العميل',
              value: invoice.customerName ?? 'غير متوفر',
            ),
            const SizedBox(height: 8),
            _buildRow(
              context,
              icon: Icons.calendar_today,
              iconColor: Colors.orange,
              label: 'التاريخ',
              value: formattedDate,
            ),
            const SizedBox(height: 8),
            _buildRow(
              context,
              icon: Icons.attach_money,
              iconColor: Colors.red,
              label: 'الإجمالي',
              value: '${invoice.invoiceTotalPrice ?? 0} ج.م',
            ),
            if (role == "Admin") ...[
              const Divider(
                height: 16,
                thickness: 1,
                color: Colors.grey,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'حذف',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _showDeleteDialog(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
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
            .then((value) => allInvoicesCubit.getAllInvoices());
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
