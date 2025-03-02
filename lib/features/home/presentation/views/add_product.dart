import 'package:elmohandes/core/resources/font_manager.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _image = TextEditingController();
  final TextEditingController _country = TextEditingController();

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

  @override
  void dispose() {
    _discount.removeListener(_calculateDiscountedPrice);
    _price.removeListener(_calculateDiscountedPrice);
    _productName.dispose();
    _price.dispose();
    _discount.dispose();
    _priceAfterDiscount.dispose();
    _image.dispose();
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;
                  return Center(
                    child: Container(
                      width: isMobile ? constraints.maxWidth * 0.9 : 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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

                          /// حقل إسم المنتج
                          _buildTextField(
                            controller: _productName,
                            label: "إسم المنتج",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال إسم المنتج";
                              }
                              return null;
                            },
                          ),

                          /// حقل السعر
                          _buildTextField(
                            controller: _price,
                            label: "السعر",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال السعر";
                              }
                              if (double.tryParse(value) == null) {
                                return "يرجى إدخال رقم صالح";
                              }
                              return null;
                            },
                          ),

                          /// حقل الخصم
                          _buildTextField(
                            controller: _discount,
                            label: "الخصم (%)",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال نسبة الخصم";
                              }
                              final discountVal = double.tryParse(value);
                              if (discountVal == null ||
                                  discountVal < 0 ||
                                  discountVal > 100) {
                                return "يرجى إدخال نسبة بين 0 و 100";
                              }
                              return null;
                            },
                          ),

                          _buildTextField(
                            controller: _priceAfterDiscount,
                            label: "السعر بعد الخصم",
                            readOnly: true,
                          ),

                          /// حقل الصورة
                          _buildTextField(
                            controller: _image,
                            label: "الصورة",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال رابط الصورة";
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _country,
                            label: "بلد الصنع",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال بلد الصنع";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          /// زر الإضافة
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // تنفيذ إضافة المنتج هنا
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                  );
                },
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
    String? Function(String?)? validator,
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
        validator: validator,
      ),
    );
  }
}
