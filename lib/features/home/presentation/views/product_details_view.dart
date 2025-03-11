import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elmohandes/core/di/di.dart';
import 'package:elmohandes/features/home/presentation/viewmodels/delete_products/delete_one_product_cubit.dart';
import 'package:elmohandes/features/home/presentation/views/add_bill_view.dart';
import 'package:elmohandes/features/home/presentation/views/home_page_view.dart';
import 'package:elmohandes/features/home/presentation/views/update_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    this.productName,
    this.price,
    this.discount,
    this.image,
    this.country,
    this.quantity,
    this.id,
  });
  final int? id;
  final String? productName;
  final num? price;
  final num? discount;
  num? get priceAfterDiscount {
    if (price != null && discount != null) {
      return price! - (price! * discount! / 100);
    }
    return null;
  }

  final String? image;
  final String? country;
  final num? quantity;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late DeleteOneProductCubit viewModel;
  @override
  void initState() {
    viewModel = getIt.get<DeleteOneProductCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 600;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.scale,
                  title: 'تحذير',
                  desc: 'أنت دلوقتي هتحذف المنتج ده نهائياً\n هل أنت متأكد؟',
                  btnCancelText: 'إلغاء',
                  btnCancelOnPress: () {},
                  btnCancelColor: Colors.blue,
                  btnOkText: 'حذف',
                  btnOkOnPress: () {
                    setState(() {
                      viewModel.deleteProduct(widget.id!);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductsPage()));
                    });
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
          ],
          centerTitle: true,
          title: Text(
            'تفاصيل المنتج',
            style: TextStyle(
              color: Colors.black,
              fontSize: isDesktop ? 24 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: isDesktop
            ? _buildDesktopLayout(screenHeight, screenWidth)
            : _buildMobileLayout(screenHeight, screenWidth),
      ),
    );
  }

  Widget _buildMobileLayout(double screenHeight, double screenWidth) {
    return Column(
      children: [
        Container(
          height: screenHeight * 0.4,
          width: screenWidth,
          decoration: BoxDecoration(
            image: widget.image != null
                ? DecorationImage(
                    image: NetworkImage(widget.image!),
                    fit: BoxFit.cover,
                  )
                : null,
            color: widget.image == null ? Colors.grey.shade300 : null,
          ),
          child: widget.image == null
              ? const Icon(Icons.image, size: 100, color: Colors.blue)
              : null,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _buildProductDetails(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _customButton('تعديل المنتج', Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProduct(
                      productName: widget.productName as String,
                      price: widget.price!.toString(),
                      discount: widget.discount!.toString(),
                      country: widget.country as String,
                      quantity: widget.quantity!.toString(),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 10),
              _customButton('إضافة فاتورة', Colors.green, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddBillPage()));
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Expanded(
            flex: 5,
            child: Container(
              height: screenHeight * 0.7,
              decoration: BoxDecoration(
                image: widget.image != null
                    ? DecorationImage(
                        image: NetworkImage(widget.image!),
                        fit: BoxFit.contain,
                      )
                    : null,
                color: widget.image == null ? Colors.grey.shade300 : null,
              ),
              child: widget.image == null
                  ? const Icon(Icons.image, size: 150, color: Colors.blue)
                  : null,
            ),
          ),

          // Details section
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductDetails(isDesktop: true),
                  const Spacer(),
                  // Buttons for desktop
                  Row(
                    children: [
                      _customButton('تعديل المنتج', Colors.blue, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProduct(
                              productName: widget.productName as String,
                              price: widget.price!.toString(),
                              discount: widget.discount!.toString(),
                              country: widget.country as String,
                              quantity: widget.quantity!.toString(),
                            ),
                          ),
                        );
                      }, isDesktop: true),
                      const SizedBox(width: 20),
                      _customButton('إضافة فاتورة', Colors.green, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddBillPage()));
                      }, isDesktop: true),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails({bool isDesktop = false}) {
    final double titleSize = isDesktop ? 30 : 22;
    final double textSize = isDesktop ? 20 : 16;
    final double priceSize = isDesktop ? 24 : 18;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.productName ?? "اسم المنتج غير متوفر",
          style: TextStyle(
            color: Colors.black,
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: isDesktop ? 20 : 10),
        Text(
          'السعر: ${widget.price} جنيه',
          style: TextStyle(color: Colors.black, fontSize: textSize),
        ),
        Text(
          'التخفيض: ${widget.discount}%',
          style: TextStyle(color: Colors.black, fontSize: textSize),
        ),
        Text(
          'بعد الخصم: ${widget.priceAfterDiscount} جنيه',
          style: TextStyle(
            color: Colors.green,
            fontSize: priceSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'الكمية: ${widget.quantity}',
          style: TextStyle(color: Colors.black, fontSize: textSize),
        ),
        SizedBox(height: isDesktop ? 20 : 10),
        Text(
          'بلد المنشأ: ${widget.country}',
          style: TextStyle(color: Colors.black, fontSize: textSize),
        ),
      ],
    );
  }

  Widget _customButton(String text, Color color, VoidCallback onPressed,
      {bool isDesktop = false}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isDesktop ? 15 : 10)),
          padding: EdgeInsets.symmetric(vertical: isDesktop ? 20 : 15),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: isDesktop ? 20 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
