import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';
import '../viewmodels/delete_one_bill/delete_one_bill_cubit.dart';
import 'display_all_bills_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceDetailsPage extends StatefulWidget {
  final String invoiceId;
  final String customerName;
  final String customerPhone;
  final String payType;
  final String productName;
  final num price;
  final num discount;
  final num amount;
  final num totalPrice;
  final String createdByName;
  final String createdOn;

  const InvoiceDetailsPage({
    super.key,
    required this.invoiceId,
    required this.customerName,
    required this.customerPhone,
    required this.payType,
    required this.productName,
    required this.price,
    required this.discount,
    required this.amount,
    required this.totalPrice,
    required this.createdByName,
    required this.createdOn,
  });

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  late DeleteOneBillCubit viewModel;

  late bool isAdmin;
  @override
  void initState() {
    String? token = CacheService.getData(key: CacheConstants.userToken);
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      isAdmin = decodedToken['roles'] != null &&
          decodedToken['roles'].contains("Admin");
    } else {
      isAdmin = false;
    }
    viewModel = getIt.get<DeleteOneBillCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (_) {
                  return const InvoicesPage();
                },
              ));
            },
          ),
          centerTitle: true,
          title: const Text(
            'تفاصيل الفاتورة',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InvoiceDetailRow(
                        title: 'رقم الفاتورة:', value: widget.invoiceId),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'اسم العميل:', value: widget.customerName),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'رقم هاتف العميل:', value: widget.customerPhone),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'طريقة الدفع:', value: widget.payType),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'اسم المنتج:', value: widget.productName),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'سعر الوحدة:', value: '${widget.price} ج.م'),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'الخصم:', value: '${widget.discount} ج.م'),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'الكمية:', value: widget.amount.toString()),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                      title: 'الإجمالي:',
                      value: '${widget.totalPrice} ج.م',
                      valueColor: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'تاريخ الفاتورة:', value: widget.createdOn),
                    const SizedBox(height: 10),
                    InvoiceDetailRow(
                        title: 'تم الإنشاء بواسطة:',
                        value: widget.createdByName.toString()),
                  ],
                ),
              ),
            ),
            // أزرار الطباعة والحذف مثبتة أسفل الشاشة
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          final pdfFile = await generatePdf();
                          await Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) async => pdfFile,
                          );
                        },
                        child: const Text(
                          'طباعة الفاتورة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (isAdmin)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 15),
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
                                  'هل أنت متأكد أنك تريد حذف الفاتورة دي؟\nلن تتمكن من استعادتها بعد الحذف!',
                              btnCancelText: 'إلغاء',
                              btnCancelOnPress: () {},
                              btnCancelColor: Colors.blue,
                              btnOkText: 'حذف',
                              btnOkOnPress: () async {
                                await viewModel.deleteOneBill(widget.invoiceId);
                                if (mounted) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (_) {
                                      return const InvoicesPage();
                                    },
                                  ));
                                }
                              },
                              btnOkColor: Colors.red,
                              dismissOnTouchOutside: false,
                              padding: const EdgeInsets.all(20),
                              buttonsBorderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ).show();
                          },
                          child: const Text(
                            'حذف الفاتورة',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.cairoRegular();
    final logoImage = await _loadLogo();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Container(
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                      child: pw.Image(logoImage, width: 100, height: 100)),
                  pw.SizedBox(height: 20),
                  pw.Center(
                    child: pw.Text(
                      'فاتورة شراء',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor(0, 0, 1),
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  _buildPdfRow(widget.invoiceId, 'رقم الفاتورة:', font),
                  _buildPdfRow(widget.customerName, 'اسم العميل:', font),
                  _buildPdfRow(widget.customerPhone, 'رقم الهاتف:', font),
                  _buildPdfRow(widget.payType, 'نوع الدفع:', font),
                  _buildPdfRow(widget.productName, 'اسم المنتج:', font),
                  _buildPdfRow('${widget.price} جنيه', 'السعر:', font),
                  _buildPdfRow('${widget.discount}%', 'الخصم:', font),
                  _buildPdfRow('${widget.amount}', 'الكمية:', font),
                  _buildPdfRow('${widget.totalPrice} جنيه', 'الإجمالي:', font),
                  _buildPdfRow(
                      widget.createdByName, 'تم الإنشاء بواسطة:', font),
                  _buildPdfRow(widget.createdOn, 'تاريخ الإنشاء:', font),
                  pw.SizedBox(height: 20),
                  pw.Divider(),
                  pw.Center(
                    child: pw.Text(
                      'شكراً لتعاملك معنا!',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<pw.ImageProvider> _loadLogo() async {
    final ByteData data =
        await rootBundle.load('assets/images/iconapplication.png');
    return pw.MemoryImage(data.buffer.asUint8List());
  }

  pw.Widget _buildPdfRow(String value, String title, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title,
              style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
          pw.Text(value, style: pw.TextStyle(font: font)),
        ],
      ),
    );
  }
}

class InvoiceDetailRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final FontWeight? fontWeight;

  const InvoiceDetailRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: valueColor ?? Colors.black,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
