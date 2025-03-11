import '../../domain/entities/add_bill_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BillDetailsView extends StatelessWidget {
  final AddBillEntity billData;

  const BillDetailsView({
    super.key,
    required this.billData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'تفاصيل الفاتورة',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(Icons.receipt, 'رقم الفاتورة:', billData.billId!),
                _buildRow(Icons.person, 'اسم العميل:', billData.customerName!),
                _buildRow(Icons.phone, 'رقم الهاتف:', billData.customerPhone!),
                _buildRow(Icons.payment, 'نوع الدفع:', billData.payType!),
                _buildRow(
                    Icons.shopping_bag, 'اسم المنتج:', billData.productName!),
                _buildRow(
                    Icons.attach_money, 'السعر:', '${billData.price} جنيه'),
                _buildRow(Icons.discount, 'الخصم:', '${billData.discount}%'),
                _buildRow(Icons.format_list_numbered, 'الكمية:',
                    '${billData.amount}'),
                _buildRow(Icons.calculate, 'الإجمالي:',
                    '${billData.totalPrice} جنيه'),
                _buildRow(Icons.person_outline, 'تم الإنشاء بواسطة:',
                    billData.createdByName!),
                _buildRow(
                    Icons.date_range, 'تاريخ الإنشاء:', billData.createdOn!),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      bool confirmPrint =
                          await _showConfirmationDialog(context);
                      if (confirmPrint) {
                        final pdf = await generatePdf();
                        await Printing.layoutPdf(onLayout: (format) => pdf);
                        await Future.delayed(const Duration(seconds: 1));
                        await Printing.layoutPdf(onLayout: (format) => pdf);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.print, color: Colors.white),
                    label: const Text(
                      "طباعة الفاتورة",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("تأكيد الطباعة"),
            content: const Text(
                "هل أنت متأكد من صحة البيانات؟ لو تمام اضغط موافق، لو مش متأكد راجعهم الأول."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("إلغاء"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("موافق"),
              ),
            ],
          ),
        ) ??
        false;
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
                  _buildPdfRow(billData.billId!, 'رقم الفاتورة:', font),
                  _buildPdfRow(billData.customerName!, 'اسم العميل:', font),
                  _buildPdfRow(billData.customerPhone!, 'رقم الهاتف:', font),
                  _buildPdfRow(billData.payType!, 'نوع الدفع:', font),
                  _buildPdfRow(billData.productName!, 'اسم المنتج:', font),
                  _buildPdfRow('${billData.price} جنيه', 'السعر:', font),
                  _buildPdfRow('${billData.discount}%', 'الخصم:', font),
                  _buildPdfRow('${billData.amount}', 'الكمية:', font),
                  _buildPdfRow(
                      '${billData.totalPrice} جنيه', 'الإجمالي:', font),
                  _buildPdfRow(
                      billData.createdByName!, 'تم الإنشاء بواسطة:', font),
                  _buildPdfRow(billData.createdOn!, 'تاريخ الإنشاء:', font),
                  pw.SizedBox(height: 20),
                  pw.Divider(),
                  pw.Center(
                    child: pw.Text(
                      'شكراً لتعاملك معنا!',
                      style: pw.TextStyle(
                          font: font,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold),
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
