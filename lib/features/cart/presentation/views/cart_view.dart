import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elmohandes/features/invoice/domain/entities/preview_invoice_entity.dart';
import 'package:elmohandes/features/invoice/presentation/view_models/cubit/preview_invoice_cubit.dart';
import '../../../../core/di/di.dart';
import '../../domain/entities/cart_details_entity.dart';
import '../view_models/cart_display/cart_details_cubit.dart';
import '../view_models/delete_from_cart/delete_cart_product_cubit.dart';
import '../../../home/presentation/views/home_page_view.dart';
import '../../../orders/presentation/views/add_Invoice_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartDetailsCubit viewModel;
  late DeleteCartProductCubit deleteCartProductCubit;
  late PreviewInvoiceCubit previewInvoiceCubit;

  @override
  void initState() {
    viewModel = getIt.get<CartDetailsCubit>();
    deleteCartProductCubit = getIt.get<DeleteCartProductCubit>();
    previewInvoiceCubit = getIt.get<PreviewInvoiceCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 600;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => viewModel..getCartDetails(),
        ),
        BlocProvider(
          create: (context) => deleteCartProductCubit,
        ),
        BlocProvider(
          create: (context) => previewInvoiceCubit,
        ),
      ],
      child: BlocBuilder<CartDetailsCubit, CartDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProductsPage();
                  }));
                },
              ),
              centerTitle: true,
              title: const Text(
                "منتجات السلة",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (state is CartDetailsLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is CartDetailsSuccess) {
                          final cartDetails = state.cartDetails;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isDesktop ? 3 : 1,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: isDesktop ? 1.5 : 1.8,
                            ),
                            itemCount: cartDetails.length,
                            itemBuilder: (context, index) {
                              return _buildCartItem(
                                  cartDetails[index], context, viewModel);
                            },
                          );
                        }
                        if (state is CartDetailsFailure) {
                          return Center(
                            child: Text('مفيش منتجات في السلة'),
                          );
                        }
                        return Center(
                          child: Text('لا يوجد منتجات في السلة'),
                        );
                      },
                    ),
                  ),
                ),
                _buildCheckoutAndPreviewButtons(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartItem(CartDetailsEntity cartDetails, BuildContext context,
      CartDetailsCubit viewModel) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 300;
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xfff5f5f5),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 2),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildProductImage(
                cartDetails.imageUrl!,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cartDetails.productName!,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: isSmallScreen ? 1 : 2,
                    ),
                    Text(
                      "السعر: ${cartDetails.price}",
                      style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "الكمية: ${cartDetails.quantity}",
                      style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "الخصم: ${cartDetails.discount}%",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 16,
                        color: Colors.red,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  if (cartDetails.productId != null) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final dialogWidth = screenWidth > 600
                        ? 500.0
                        : null; // Set width for desktop

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.bottomSlide,
                      title: 'تحذير',
                      desc: 'هل أنت متأكد أنك تريد حذف هذا المنتج من السلة؟',
                      btnCancelText: 'إلغاء',
                      btnOkText: 'حذف',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        deleteCartProductCubit
                            .deleteProductFromCart(cartDetails.productId!)
                            .then((_) {
                          setState(() {
                            viewModel.getCartDetails();
                          });
                        });
                      },
                      width: dialogWidth,
                    ).show();
                  } else {
                    log("Error: Product ID is null!");
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductImage(
    String productImage,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 300;
        final imageSize =
            isSmallScreen ? 60.0 : 80.0; // Adjust size for small screens
        return Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: productImage,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 50),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckoutAndPreviewButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (viewModel.state is CartDetailsSuccess &&
                    (viewModel.state as CartDetailsSuccess)
                        .cartDetails
                        .isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddInvoiceView();
                  }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "مفيش منتجات في السلة",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      duration: Duration(milliseconds: 200), // Reduced duration
                    ),
                  );
                }
              },
              child: const Text("إنشاء فاتورة",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: BlocBuilder<PreviewInvoiceCubit, PreviewInvoiceState>(
              builder: (context, state) {
                if (state is PreviewInvoiceLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await previewInvoiceCubit.getInvoicePreview();
                    final previewState = previewInvoiceCubit.state;

                    if (previewState is PreviewInvoiceSuccess) {
                      await generateInvoicePdf(
                          context, previewState.previewInvoiceEntity);
                    } else if (previewState is PreviewInvoiceFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            previewState.message,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          duration: const Duration(
                              milliseconds: 200), // Reduced duration
                          action: SnackBarAction(
                            label: 'إعادة المحاولة',
                            textColor: Colors.yellow,
                            onPressed: () {
                              previewInvoiceCubit.getInvoicePreview();
                            },
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("فشل تحميل بيانات الفاتورة"),
                          duration:
                              Duration(milliseconds: 200), // Reduced duration
                        ),
                      );
                    }
                  },
                  child: const Text("معاينة الفاتورة",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> generateInvoicePdf(
    BuildContext context,
    PreviewInvoiceEntity previewInvoice,
  ) async {
    final pdf = pw.Document();
    // String totalPriceWords =
    //     convertNumberToArabicWords(invoiceData.invoiceTotalPrice!);
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

    DateTime createdAt;
    if (previewInvoice.createdAt is String) {
      createdAt =
          DateTime.tryParse(previewInvoice.createdAt as String)?.toLocal() ??
              DateTime.now();
    } else if (previewInvoice.createdAt is DateTime) {
      createdAt = (previewInvoice.createdAt as DateTime).toLocal();
    } else {
      createdAt = DateTime.now();
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
                        fontWeight: pw.FontWeight.bold)),
                pw.Text("معاينة الفاتورة",
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // pw.Text("رقم الفاتورة: ${previewInvoice.invoiceNumber}",
                        //     style: pw.TextStyle(font: ttf, fontSize: 12)),
                        // pw.Text("اسم العميل: ${previewInvoice.customerName}",
                        //     style: pw.TextStyle(font: ttf, fontSize: 12)),
                        // pw.Text("رقم الهاتف: ${previewInvoice.customerPhone}",
                        //     style: pw.TextStyle(font: ttf, fontSize: 12)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        // pw.Text("طريقة الدفع: ${invoiceData.payType}",
                        //     style: pw.TextStyle(font: ttf, fontSize: 12)),
                        // pw.Text("المحاسب: ${invoiceData.casherName}",
                        //     style: pw.TextStyle(font: ttf, fontSize: 12)),
                        // pw.Text("تاريخ الفاتورة: $formattedDate",
                        //     style: pw.TextStyle(font: ttf, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Table(
                  border:
                      pw.TableBorder.all(color: PdfColors.black, width: 0.8),
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
                        buildPdfCell("الإجمالي", ttf,
                            isHeader: true), // الإجمالي
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
                    ...?previewInvoice.invoiceItems?.asMap().entries.map(
                      (entry) {
                        final index = entry.key + 1;
                        final item = entry.value;
                        return pw.TableRow(
                          children: [
                            buildPdfCell(
                                "${item.totalPrice ?? 0}", ttf), // الإجمالي
                            buildPdfCell(
                                "${item.discount ?? 0}%", ttf), // الخصم
                            buildPdfCell(
                                "${item.quantity ?? 0}", ttf), // الكمية
                            buildPdfCell(
                                "${item.unitPrice ?? 0}", ttf), // السعر
                            buildPdfCell(item.countryOfOrigin ?? 'غير معروف',
                                ttf), // بلد الصنع
                            buildPdfCell(item.productName ?? "غير معروف",
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
                            "السعر الإجمالي: ${previewInvoice.totalAmount} ج.م",
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold)),
                        // pw.Text("($totalPriceWords)",
                        //     style: pw.TextStyle(
                        //         font: ttf,
                        //         fontSize: 10,
                        //         fontWeight: pw.FontWeight.bold)),
                        // pw.SizedBox(height: 3),
                        // pw.Text("مدفوع: ................................",
                        //     style: pw.TextStyle(font: ttf, fontSize: 10)),
                        // pw.Text("الباقي: ..................................",
                        //     style: pw.TextStyle(font: ttf, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Center(
                  child: pw.Text(
                    "العنوان هيكون هنا / وارقام التليفون",
                    style: pw.TextStyle(
                        font: ttf,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    try {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save());
    } catch (e) {
      log("Error printing PDF: $e");
    }
  }
}
