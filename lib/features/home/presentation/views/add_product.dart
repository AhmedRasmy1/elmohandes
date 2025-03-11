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
                  fontWeight: FontWeight.bold),
            )),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال اسم المنتج';
                        }
                        return null;
                      }),
                  _buildTextField(
                      controller: _price,
                      label: "السعر",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال السعر';
                        }
                        if (double.tryParse(value) == null) {
                          return 'يرجى إدخال سعر صالح';
                        }
                        return null;
                      }),
                  _buildTextField(
                      controller: _discount,
                      label: "الخصم (%)",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال الخصم';
                        }
                        if (double.tryParse(value) == null) {
                          return 'يرجى إدخال خصم صالح';
                        }
                        return null;
                      }),
                  _buildTextField(
                      controller: _quantity,
                      label: "الكمية",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال الكمية';
                        }
                        if (int.tryParse(value) == null) {
                          return 'يرجى إدخال كمية صالحة';
                        }
                        return null;
                      }),
                  _buildTextField(
                      controller: _priceAfterDiscount,
                      label: "السعر بعد الخصم",
                      readOnly: true),
                  _buildTextField(
                      controller: _country,
                      label: "بلد الصنع",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال بلد الصنع';
                        }
                        return null;
                      }),
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
                        ),
                        child: _selectedImage == null
                            ? const Center(child: Text("اختر صورة للمنتج"))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(_selectedImage!,
                                    fit: BoxFit.contain),
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
                          title: 'تمام المنتج اتضاف بنجاح',
                          desc:
                              'من فضلك في حال عدم ظهور المنتج الجديد في صفحة المنتجات \n اعمل ريفريش للصفحة عشان المنتج يتضاف',
                          btnOkText: 'تمام',
                          btnOkOnPress: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const ProductsPage();
                            }));
                          },
                          btnOkColor: Colors.green,
                          dismissOnTouchOutside: false,
                          padding: const EdgeInsets.all(20),
                          buttonsBorderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          width: MediaQuery.of(context).size.width *
                              (MediaQuery.of(context).size.width < 600
                                  ? 0.8
                                  : 0.8),
                        ).show();
                      } else if (state is Addproductfailure) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.scale,
                          title: 'للاسف المنتج متضافش',
                          desc:
                              'راجع لو ناسي اي حاجة مش ضايفها او في  غلط في الاضافة ',
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
                      return Center(
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
                                // ignore: use_build_context_synchronously
                                context
                                    .read<AddproductCubit>()
                                    .addProduct(formData: formData);
                              }
                            } else {
                              // AwesomeDialog(
                              //   context: context,
                              //   dialogType: DialogType.warning,
                              //   animType: AnimType.scale,
                              //   title: 'خطأ',
                              //   desc: 'يرجى ملء جميع الحقول وإضافة صورة',
                              //   btnOkText: 'تمام ✅',
                              //   btnOkOnPress: () {},
                              //   btnOkColor: Colors.orange,
                              //   dismissOnTouchOutside: false,
                              //   padding: const EdgeInsets.all(20),
                              //   borderSide: const BorderSide(
                              //       color: Colors.red, width: 2),
                              //   buttonsBorderRadius:
                              //       const BorderRadius.all(Radius.circular(10)),
                              //   width: MediaQuery.of(context).size.width *
                              //       (MediaQuery.of(context).size.width < 600
                              //           ? 0.8
                              //           : 0.8),
                              // ).show();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.9, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: state is AddproductLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text("إضافة المنتج",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white)),
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
        textAlign: TextAlign.right, // يخلي النص لليمين
        style: const TextStyle(fontSize: 16), // زيادة حجم الخط
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 16), // تنسيق الحواف الداخلية
          alignLabelWithHint: true, // يضبط الليبل مع النص
        ),
        validator: validator,
      ),
    );
  }
}
