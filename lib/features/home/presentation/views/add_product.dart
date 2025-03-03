import 'dart:io';
import 'package:elmohandes/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String fontFamily;
  const AddProduct({super.key, this.fontFamily = FontFamily.cairo});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _priceAfterDiscount = TextEditingController();
  final TextEditingController _country = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _discount.addListener(_calculateDiscountedPrice);
    _price.addListener(_calculateDiscountedPrice);
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
  void dispose() {
    _discount.removeListener(_calculateDiscountedPrice);
    _price.removeListener(_calculateDiscountedPrice);
    _productName.dispose();
    _price.dispose();
    _discount.dispose();
    _priceAfterDiscount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text(
                    "إضافة منتج",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: FontFamily.cairoSemiBold,
                    ),
                  ),
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
                      controller: _priceAfterDiscount,
                      label: "السعر بعد الخصم",
                      readOnly: true),
                  _buildTextField(controller: _country, label: "بلد الصنع"),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _selectedImage == null
                          ? const Center(child: Text("اختر صورة للمنتج"))
                          : Image.file(_selectedImage!, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _selectedImage != null) {
                          // تنفيذ إضافة المنتج هنا
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "إضافة المنتج",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: FontFamily.cairo,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
          labelStyle: TextStyle(fontFamily: widget.fontFamily),
          border: OutlineInputBorder(),
        ),
        style: TextStyle(fontFamily: widget.fontFamily),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "يرجى إدخال $label";
          }
          return null;
        },
      ),
    );
  }
}
