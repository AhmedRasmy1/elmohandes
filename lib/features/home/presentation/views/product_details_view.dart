import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../cart/presentation/view_models/cart_cubit/add_product_to_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../viewmodels/delete_products/delete_one_product_cubit.dart';
import 'home_page_view.dart';
import 'update_product_view.dart';

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
  late AddProductToCartCubit addToCartCubit;
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    viewModel = getIt.get<DeleteOneProductCubit>();
    addToCartCubit = getIt.get<AddProductToCartCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => viewModel,
        ),
        BlocProvider(
          create: (context) => addToCartCubit,
        ),
      ],
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
                          builder: (context) => const ProductsPage(),
                        ),
                      );
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildDesktopLayout(
                  constraints.maxHeight, constraints.maxWidth);
            } else {
              return _buildMobileLayout(
                  constraints.maxHeight, constraints.maxWidth);
            }
          },
        ),
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
            color: widget.image == null ? Colors.grey.shade300 : null,
          ),
          child: widget.image != null
              ? CachedNetworkImage(
                  imageUrl: widget.image!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                )
              : const Icon(Icons.image, size: 100, color: Colors.blue),
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
                      productName: widget.productName!,
                      price: widget.price!.toString(),
                      discount: widget.discount!.toString(),
                      country: widget.country!,
                      quantity: widget.quantity!.toString(),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 10),
              _customButton('إضافة للسلة', Colors.green, () {
                _showAddToCartDialog();
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double screenHeight, double screenWidth) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: screenHeight * 0.7,
            decoration: BoxDecoration(
              color: widget.image == null ? Colors.grey.shade300 : null,
            ),
            child: widget.image != null
                ? CachedNetworkImage(
                    imageUrl: widget.image!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
                  )
                : const Icon(Icons.image, size: 100, color: Colors.blue),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductDetails(isDesktop: true),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _customButton('تعديل المنتج', Colors.blue, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProduct(
                            productName: widget.productName!,
                            price: widget.price!.toString(),
                            discount: widget.discount!.toString(),
                            country: widget.country!,
                            quantity: widget.quantity!.toString(),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(width: 20),
                    _customButton('إضافة للسلة', Colors.green, () {
                      _showAddToCartDialog();
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAddToCartDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'إضافة للسلة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          content: SingleChildScrollView(
            child: Wrap(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'أدخل الكمية',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'الكمية المتاحة: ${widget.quantity}',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء',
                  style: TextStyle(color: Colors.red, fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                int quantity = int.tryParse(_quantityController.text) ?? 0;
                Navigator.pop(context);
                if (quantity > 0 && quantity <= widget.quantity!) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تمت إضافة $quantity للسلة'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  addToCartCubit.addProductToCart(widget.id!, quantity);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('الكمية غير متاحة'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Text('تمام',
                  style: TextStyle(color: Colors.blue, fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductDetails({bool isDesktop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.productName ?? "اسم المنتج غير متوفر",
          style: TextStyle(
            color: Colors.black,
            fontSize: isDesktop ? 30 : 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'السعر: ${widget.price} جنيه',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        Text(
          'التخفيض: ${widget.discount}%',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        Text(
          'بعد الخصم: ${widget.priceAfterDiscount} جنيه',
          style: TextStyle(
            color: Colors.green,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'الكمية: ${widget.quantity}',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        Text(
          'بلد المنشأ: ${widget.country}',
          style: TextStyle(color: Colors.black, fontSize: 16),
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
