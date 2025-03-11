import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/cashed_data_shared_preferences.dart';
import '../viewmodels/update_productss/update_products_cubit.dart';
import 'home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/font_manager.dart';

class UpdateProduct extends StatefulWidget {
  final String fontFamily;
  final String productName;
  final String price;
  final String discount;
  final String country;
  final String quantity;

  const UpdateProduct({
    super.key,
    this.fontFamily = FontFamily.cairo,
    required this.productName,
    required this.price,
    required this.discount,
    required this.country,
    required this.quantity,
  });

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _productName;
  late TextEditingController _price;
  late TextEditingController _discount;
  late final TextEditingController _priceAfterDiscount =
      TextEditingController();
  late TextEditingController _country;
  late TextEditingController _quantity;
  late UpdateProductsCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<UpdateProductsCubit>();
    super.initState();
    _productName = TextEditingController(text: widget.productName);
    _price = TextEditingController(text: widget.price);
    _discount = TextEditingController(text: widget.discount);

    _country = TextEditingController(text: widget.country);
    _quantity = TextEditingController(text: widget.quantity);
    _price.addListener(_updatePriceAfterDiscount);
    _discount.addListener(_updatePriceAfterDiscount);
  }

  @override
  void dispose() {
    _price.removeListener(_updatePriceAfterDiscount);
    _discount.removeListener(_updatePriceAfterDiscount);

    _productName.dispose();
    _price.dispose();
    _discount.dispose();
    _priceAfterDiscount.dispose();
    _country.dispose();
    _quantity.dispose();
    super.dispose();
  }

  void _updatePriceAfterDiscount() {
    final price = double.tryParse(_price.text) ?? 0.0;
    final discount = double.tryParse(_discount.text) ?? 0.0;
    final priceAfterDiscount = price - (price * discount / 100);
    _priceAfterDiscount.text = priceAfterDiscount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "تعديل المنتج",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _buildTextField(
                        controller: _productName, label: "إسم المنتج"),
                    _buildTextField(
                        controller: _price,
                        label: "السعر",
                        keyboardType: TextInputType.number),
                    _buildTextField(
                        controller: _discount,
                        label: "الخصم (%)",
                        keyboardType: TextInputType.number),
                    _buildTextField(
                        controller: _quantity,
                        label: "الكمية",
                        keyboardType: TextInputType.number),
                    _buildTextField(
                        controller: _priceAfterDiscount,
                        label: "السعر بعد الخصم",
                        readOnly: true),
                    _buildTextField(controller: _country, label: "بلد الصنع"),
                    const SizedBox(height: 20),
                    BlocConsumer<UpdateProductsCubit, UpdateProductsState>(
                      listener: (context, state) {
                        if (state is UpdateProductsSuccess) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.scale,
                            title: ' المنتج اتحدث بنجاح',
                            desc:
                                'المنتج اتحدث بنجاح وممكن تشوفه في الصفحة المنتجات',
                            btnOkText: 'تمام',
                            btnOkOnPress: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return ProductsPage();
                                },
                              ));
                            },
                            btnOkColor: Colors.green,
                            dismissOnTouchOutside: false,
                            padding: const EdgeInsets.all(20),
                            buttonsBorderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            width: MediaQuery.of(context).size.width *
                                (MediaQuery.of(context).size.width < 600
                                    ? 0.9
                                    : 0.8),
                          ).show();
                        }
                        if (state is UpdateProductsFailure) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.scale,
                            title: 'للاسف المنتج متحدثش',
                            desc:
                                'راجع لو ناسي اي حاجة مش ضايفها او في  غلط في التحديث ',
                            btnOkText: 'تمام',
                            btnOkOnPress: () {},
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
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.updateProduct(
                                id: CacheService.getData(
                                    key: CacheConstants.productId),
                                name: _productName.text,
                                countryOfOrigin: _country.text,
                                price: num.parse(_price.text),
                                quantity: num.parse(_quantity.text),
                                discount: num.parse(_discount.text),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "تحديث المنتج",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        ),
      ),
    );
  }
}
