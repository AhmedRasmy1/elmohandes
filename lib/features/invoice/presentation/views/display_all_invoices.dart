import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elmohandes/core/di/di.dart';
import 'package:elmohandes/features/home/presentation/views/home_page_view.dart';
import 'package:elmohandes/features/invoice/domain/entities/all_invoices_entity.dart';
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
  List<AllInvoiceEntity> allInvoices = [];

  @override
  void initState() {
    super.initState();
    role = CacheService.getData(key: CacheConstants.role) ?? "";
    allInvoicesCubit = getIt.get<AllInvoicesCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => allInvoicesCubit..getAllInvoices(),
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
                            ? ListView.builder(
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
                                        invoice: allInvoices[index]),
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
                          ? ListView.builder(
                              itemCount: filteredInvoices.length,
                              itemBuilder: (context, index) {
                                return InvoiceCard(
                                    invoice: filteredInvoices[index]);
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
                            // تنفيذ الحذف هنا
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

  const InvoiceCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    // تحويل التاريخ للصيغة المطلوبة
    String formattedDate = "غير متوفر";
    if (invoice.createdAt != null && invoice.createdAt!.isNotEmpty) {
      DateTime? parsedDate = DateTime.tryParse(invoice.createdAt!);
      if (parsedDate != null) {
        formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
      }
    }

    // الحصول على الدور من التخزين المؤقت
    String role = CacheService.getData(key: CacheConstants.role) ?? "";

    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.receipt, color: Colors.blue, size: 30),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'رقم الفاتورة: ${invoice.invoiceNumber ?? 'غير متوفر'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.green, size: 25),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'العميل: ${invoice.customerName ?? 'غير متوفر'}',
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    color: Colors.orange, size: 25),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'التاريخ: $formattedDate',
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.red, size: 25),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'الإجمالي: ${invoice.invoiceTotalPrice ?? 0} ج.م',
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (role == "Admin")
              const Divider(
                height: 20,
                thickness: 1,
                color: Colors.grey,
              ),
            if (role == "Admin")
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text(
                    'حذف',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
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
                        // تنفيذ الحذف هنا
                        // BlocProvider.of<AllInvoicesCubit>(context)
                        //     .deleteInvoice(invoice.id);
                      },
                      btnOkColor: Colors.red,
                      dismissOnTouchOutside: false,
                      padding: const EdgeInsets.all(20),
                      buttonsBorderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                      width: MediaQuery.of(context).size.width *
                          (MediaQuery.of(context).size.width < 600 ? 0.9 : 0.8),
                    ).show();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
