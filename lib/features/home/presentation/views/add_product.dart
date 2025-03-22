import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../../core/di/di.dart';
import '../../../../core/resources/font_manager.dart';
import '../viewmodels/add_productss/addproduct_cubit.dart';

class AddProduct extends StatefulWidget {
  final String fontFamily;
  const AddProduct({super.key, this.fontFamily = FontFamily.cairo});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late AddproductCubit viewModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _priceAfterDiscount = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _discount.addListener(_calculateDiscountedPrice);
    _price.addListener(_calculateDiscountedPrice);
    viewModel = getIt.get<AddproductCubit>();
  }

  void _calculateDiscountedPrice() {
    final priceVal = double.tryParse(_price.text) ?? 0;
    final discountVal = double.tryParse(_discount.text) ?? 0;
    setState(() {
      if (priceVal > 0 && discountVal > 0) {
        _priceAfterDiscount.text =
            (priceVal - (priceVal * discountVal / 100)).toStringAsFixed(2);
      } else {
        _priceAfterDiscount.clear();
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "إضافة منتج",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    controller: _productName,
                    label: "إسم المنتج",
                    icon: Icons.shopping_bag,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال اسم المنتج';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _price,
                    label: "السعر",
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال السعر';
                      }
                      if (double.tryParse(value) == null) {
                        return 'يرجى إدخال سعر صالح';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _discount,
                    label: "الخصم (%)",
                    icon: Icons.percent,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الخصم';
                      }
                      if (double.tryParse(value) == null) {
                        return 'يرجى إدخال خصم صالح';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _quantity,
                    label: "الكمية",
                    icon: Icons.production_quantity_limits,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الكمية';
                      }
                      if (int.tryParse(value) == null) {
                        return 'يرجى إدخال كمية صالحة';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _priceAfterDiscount,
                    label: "السعر بعد الخصم",
                    icon: Icons.price_check,
                    readOnly: true,
                  ),
                  _buildTextField(
                    controller: _country,
                    label: "بلد الصنع",
                    icon: Icons.flag,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال بلد الصنع';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          image: _selectedImage == null
                              ? const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/placeholder.png'),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _selectedImage == null
                            ? const Center(
                                child: Text(
                                  "اختر صورة للمنتج",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AddproductCubit, AddproductState>(
                    listener: (context, state) {
                      if (state is AddproductSuccess) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.scale,
                          title: 'تم إضافة المنتج بنجاح',
                          desc:
                              'في حال عدم ظهور المنتج الجديد، يرجى تحديث الصفحة.',
                          btnOkText: 'تمام',
                          btnOkOnPress: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const ProductsPage();
                            }));
                          },
                          btnOkColor: Colors.green,
                          dismissOnTouchOutside: false,
                        ).show();
                      } else if (state is Addproductfailure) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.scale,
                          title: 'خطأ',
                          desc: 'حدث خطأ أثناء إضافة المنتج.',
                          btnOkText: 'حسناً',
                          btnOkOnPress: () {},
                          btnOkColor: Colors.red,
                          dismissOnTouchOutside: false,
                        ).show();
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  _selectedImage != null) {
                                File file = File(_selectedImage!.path);
                                String fileNameWithExtension =
                                    basename(file.path);
                                FormData formData = FormData.fromMap({
                                  "name": _productName.text,
                                  "price": num.parse(_price.text),
                                  "discount": num.parse(_discount.text),
                                  "quantity": num.parse(_quantity.text),
                                  "countryOfOrigin": _country.text,
                                  "Cover": await MultipartFile.fromFile(
                                    _selectedImage!.path,
                                    filename: fileNameWithExtension,
                                  ),
                                  "CreatedAt":
                                      DateTime.now().toUtc().toIso8601String(),
                                });
                                if (mounted) {
                                  context
                                      .read<AddproductCubit>()
                                      .addProduct(formData: formData);
                                }
                              } else if (_selectedImage == null) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.scale,
                                  title: 'تنبيه',
                                  desc: 'يرجى اختيار صورة للمنتج.',
                                  btnOkText: 'حسناً',
                                  btnOkOnPress: () {},
                                  btnOkColor: Colors.orange,
                                  dismissOnTouchOutside: false,
                                ).show();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.blue,
                              elevation: 5,
                              shadowColor: Colors.blueAccent,
                            ),
                            child: state is AddproductLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "إضافة المنتج",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        validator: validator,
      ),
    );
  }
}
