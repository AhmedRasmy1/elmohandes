import '../../domain/entities/all_invoices_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

class InvoicePageDetails extends StatelessWidget {
  final AllInvoiceEntity invoiceData;

  const InvoicePageDetails({super.key, required this.invoiceData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'تفاصيل الفاتورة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'المهندس',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ArefRuqaa'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCustomerInfo(),
                  const SizedBox(height: 10),
                  _buildInvoiceTable(constraints.maxWidth),
                  const SizedBox(height: 20),
                  _buildTotalSection(),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          generateInvoicePdf(context, invoiceData);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "طباعة الفاتورة",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
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
  }

  Widget _buildCustomerInfo() {
    DateTime createdAt;
    if (invoiceData.createdAt is String) {
      createdAt = DateTime.tryParse(invoiceData.createdAt!)
              ?.toLocal()
              .add(const Duration(hours: 2)) ??
          DateTime.now().add(const Duration(hours: 2));
    } else if (invoiceData.createdAt is DateTime) {
      createdAt = (invoiceData.createdAt as DateTime)
          .toLocal()
          .add(const Duration(hours: 2));
    } else {
      createdAt = DateTime.now().add(const Duration(hours: 2));
    }

    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(createdAt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.receipt_long, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              "رقم الفاتورة: ${invoiceData.invoiceNumber}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.person, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              "اسم العميل: ${invoiceData.customerName}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.orange),
            const SizedBox(width: 8),
            Text(
              "رقم التليفون: ${invoiceData.customerPhone}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.payment, color: Colors.purple),
            const SizedBox(width: 8),
            Text(
              "طريقة الدفع: ${invoiceData.payType}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.person_outline, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              "الكاشير: ${invoiceData.casherName}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.teal),
            const SizedBox(width: 8),
            Text(
              "تاريخ الفاتورة: $formattedDate",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInvoiceTable(double maxWidth) {
    bool isMobile = maxWidth < 600;

    return Table(
      border: TableBorder.all(),
      columnWidths: isMobile
          ? {
              0: const FlexColumnWidth(2), // اسم المنتج
              1: const FlexColumnWidth(1), // السعر
              2: const FlexColumnWidth(1), // الكمية
              3: const FlexColumnWidth(1), // الإجمالي
            }
          : {
              0: const FlexColumnWidth(2), // اسم المنتج
              1: const FlexColumnWidth(1), // بلد الصنع
              2: const FlexColumnWidth(1), // السعر
              3: const FlexColumnWidth(1), // الكمية
              4: const FlexColumnWidth(1), // الخصم
              5: const FlexColumnWidth(1), // الإجمالي
            },
      children: [
        _buildTableHeader(isMobile),
        ...?invoiceData.invoiceItems
            ?.map((item) => _buildTableRow(item, isMobile)),
      ],
    );
  }

  TableRow _buildTableHeader(bool isMobile) {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.grey),
      children: isMobile
          ? [
              _buildTableCell("اسم المنتج", isHeader: true),
              _buildTableCell("السعر", isHeader: true),
              _buildTableCell("الكمية", isHeader: true),
              _buildTableCell("الإجمالي", isHeader: true),
            ]
          : [
              _buildTableCell("اسم المنتج", isHeader: true),
              _buildTableCell("بلد الصنع", isHeader: true),
              _buildTableCell("السعر", isHeader: true),
              _buildTableCell("الكمية", isHeader: true),
              _buildTableCell("الخصم", isHeader: true),
              _buildTableCell("الإجمالي", isHeader: true),
            ],
    );
  }

  TableRow _buildTableRow(invoiceItem, bool isMobile) {
    return TableRow(
      children: isMobile
          ? [
              _buildTableCell(invoiceItem.product?.name ?? "غير معروف"),
              _buildTableCell("${invoiceItem.product?.price ?? 0}"),
              _buildTableCell("${invoiceItem.quantity ?? 0}"),
              _buildTableCell("${invoiceItem.totalPrice ?? 0}"),
            ]
          : [
              _buildTableCell(invoiceItem.product?.name ?? "غير معروف"),
              _buildTableCell(
                  "${invoiceItem.product?.countryOfOrigin ?? 'غير معروف'}"),
              _buildTableCell("${invoiceItem.product?.price ?? 0}"),
              _buildTableCell("${invoiceItem.quantity ?? 0}"),
              _buildTableCell("${invoiceItem.product?.discount ?? 0}%"),
              _buildTableCell("${invoiceItem.totalPrice ?? 0}"),
            ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    String totalPriceWords =
        convertNumberToArabicWords(invoiceData.invoiceTotalPrice!);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "السعر الإجمالي: ${invoiceData.invoiceTotalPrice} ج.م",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "($totalPriceWords جنيه مصري)", // عرض الرقم بالكلمات
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

Future<void> generateInvoicePdf(
    BuildContext context, AllInvoiceEntity invoiceData) async {
  final pdf = pw.Document();

  final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);

  final ByteData imageData =
      await rootBundle.load("assets/images/iconapplication.png");
  final Uint8List imageBytes = imageData.buffer.asUint8List();
  final pw.MemoryImage logo = pw.MemoryImage(imageBytes);

  pw.Widget buildPdfCell(String text, pw.Font font, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4.0),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          font: font,
          fontSize: isHeader ? 10 : 8,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  String totalPriceWords =
      convertNumberToArabicWords(invoiceData.invoiceTotalPrice!);
  DateTime createdAt;
  if (invoiceData.createdAt is String) {
    createdAt = DateTime.tryParse(invoiceData.createdAt!)
            ?.toLocal()
            .add(const Duration(hours: 2)) ??
        DateTime.now().add(const Duration(hours: 2));
  } else if (invoiceData.createdAt is DateTime) {
    createdAt = (invoiceData.createdAt as DateTime)
        .toLocal()
        .add(const Duration(hours: 2));
  } else {
    createdAt = DateTime.now().add(const Duration(hours: 2));
  }

  String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(createdAt);
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      theme: pw.ThemeData.withFont(base: ttf),
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                height: 50,
                width: 50,
                child: pw.Image(logo),
              ),
              pw.SizedBox(height: 5),
              pw.Text("المهندس",
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.Text("فاتورة شراء",
                  style: pw.TextStyle(
                      font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("رقم الفاتورة: ${invoiceData.invoiceNumber}",
                          style: pw.TextStyle(font: ttf, fontSize: 12)),
                      pw.Text("اسم العميل: ${invoiceData.customerName}",
                          style: pw.TextStyle(font: ttf, fontSize: 12)),
                      pw.Text("رقم الهاتف: ${invoiceData.customerPhone}",
                          style: pw.TextStyle(font: ttf, fontSize: 12)),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text("طريقة الدفع: ${invoiceData.payType}",
                          style: pw.TextStyle(font: ttf, fontSize: 12)),
                      pw.Text("المحاسب: ${invoiceData.casherName}",
                          style: pw.TextStyle(font: ttf, fontSize: 12)),
                      pw.Text("تاريخ الفاتورة: $formattedDate",
                          style: pw.TextStyle(font: ttf, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black, width: 0.8),
                columnWidths: {
                  0: pw.FlexColumnWidth(0.8), // الإجمالي
                  1: pw.FlexColumnWidth(0.8), // الخصم
                  2: pw.FlexColumnWidth(0.8), // الكمية
                  3: pw.FlexColumnWidth(0.8), // السعر
                  4: pw.FlexColumnWidth(0.8), // بلد الصنع
                  5: pw.FlexColumnWidth(1.2), // اسم المنتج
                  6: pw.FlexColumnWidth(0.3), // م (التسلسل)
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey),
                    children: [
                      buildPdfCell("الإجمالي", ttf, isHeader: true), // الإجمالي
                      buildPdfCell("الخصم", ttf, isHeader: true), // الخصم
                      buildPdfCell("الكمية", ttf, isHeader: true), // الكمية
                      buildPdfCell("السعر", ttf, isHeader: true), // السعر
                      buildPdfCell("بلد الصنع", ttf,
                          isHeader: true), // بلد الصنع
                      buildPdfCell("اسم المنتج", ttf,
                          isHeader: true), // اسم المنتج
                      buildPdfCell("م", ttf, isHeader: true), // التسلسل
                    ],
                  ),
                  ...?invoiceData.invoiceItems?.asMap().entries.map(
                    (entry) {
                      final index = entry.key + 1;
                      final item = entry.value;
                      return pw.TableRow(
                        children: [
                          buildPdfCell(
                              "${item.totalPrice ?? 0}", ttf), // الإجمالي
                          buildPdfCell(
                              "${item.product?.discount ?? 0}%", ttf), // الخصم
                          buildPdfCell("${item.quantity ?? 0}", ttf), // الكمية
                          buildPdfCell(
                              "${item.product?.price ?? 0}", ttf), // السعر
                          buildPdfCell(
                              item.product?.countryOfOrigin ?? 'غير معروف',
                              ttf), // بلد الصنع
                          buildPdfCell(item.product?.name ?? "غير معروف",
                              ttf), // اسم المنتج
                          buildPdfCell("$index", ttf), // التسلسل
                        ],
                      );
                    },
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          "السعر الإجمالي: ${invoiceData.invoiceTotalPrice} ج.م",
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold)),
                      pw.Text("($totalPriceWords)",
                          style: pw.TextStyle(
                              font: ttf,
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 3),
                      pw.Text("مدفوع: ................................",
                          style: pw.TextStyle(font: ttf, fontSize: 10)),
                      pw.Text("الباقي: ..................................",
                          style: pw.TextStyle(font: ttf, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text(
                  "العنوان هيكون هنا / وارقام التليفون",
                  style: pw.TextStyle(
                      font: ttf, fontWeight: pw.FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
  // Print the first copy
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());

  // Print the second copy
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}

String convertNumberToArabicWords(num number) {
  final List<String> units = [
    "",
    "واحد",
    "اثنان",
    "ثلاثة",
    "أربعة",
    "خمسة",
    "ستة",
    "سبعة",
    "ثمانية",
    "تسعة"
  ];
  final List<String> teens = [
    "عشرة",
    "أحد عشر",
    "اثنا عشر",
    "ثلاثة عشر",
    "أربعة عشر",
    "خمسة عشر",
    "ستة عشر",
    "سبعة عشر",
    "ثمانية عشر",
    "تسعة عشر"
  ];
  final List<String> tens = [
    "",
    "",
    "عشرون",
    "ثلاثون",
    "أربعون",
    "خمسون",
    "ستون",
    "سبعون",
    "ثمانون",
    "تسعون"
  ];
  final List<String> hundreds = [
    "",
    "مئة",
    "مئتان",
    "ثلاثمئة",
    "أربعمئة",
    "خمسمئة",
    "ستمئة",
    "سبعمئة",
    "ثمانمئة",
    "تسعمئة"
  ];

  String processSection(
      int number, String singular, String dual, String plural) {
    if (number == 0) return "";
    if (number == 1) return singular;
    if (number == 2) return dual;
    if (number >= 3 && number <= 10) return "$number $plural";
    return "${convertNumberToArabicWords(number)} $singular";
  }

  if (number == 0) return "صفر";

  List<String> words = [];

  int billionPart = number ~/ 1000000000;
  number %= 1000000000;
  if (billionPart > 0) {
    words.add(processSection(billionPart, "مليار", "ملياران", "مليارات"));
  }

  int millionPart = number ~/ 1000000;
  number %= 1000000;
  if (millionPart > 0) {
    words.add(processSection(millionPart, "مليون", "مليونان", "ملايين"));
  }

  int thousandPart = number ~/ 1000;
  number %= 1000;
  if (thousandPart > 0) {
    words.add(processSection(thousandPart, "ألف", "ألفان", "آلاف"));
  }

  int hundredPart = number ~/ 100;
  number %= 100;
  if (hundredPart > 0) {
    words.add(hundreds[hundredPart]);
  }

  if (number >= 10 && number < 20) {
    words.add(teens[number.toInt() - 10]);
  } else {
    int tenPart = number.toInt() ~/ 10;
    int unitPart = number.toInt() % 10;
    if (tenPart > 0) {
      words.add(tens[tenPart]);
    }
    if (unitPart > 0) {
      words.add(units[unitPart]);
    }
  }

  return words.join(" و ").trim();
}
