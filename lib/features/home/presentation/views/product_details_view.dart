import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    this.productName,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.image,
    this.country,
  });

  final String? productName;
  final double? price;
  final double? discount;
  final double? priceAfterDiscount;
  final String? image;
  final String? country;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 600;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'تفاصيل المنتج',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// صورة المنتج - تاخد نص الشاشة
          Container(
            height: screenHeight * 0.4,
            width: screenWidth,
            decoration: BoxDecoration(
              image: widget.image != null
                  ? DecorationImage(
                      image: AssetImage('assets/images/hafara.jpeg'),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: widget.image == null ? Colors.grey.shade300 : null,
            ),
            child: widget.image == null
                ? const Icon(Icons.image, size: 100, color: Colors.blue)
                : null,
          ),

          /// باقي التفاصيل
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName ?? "اسم المنتج غير متوفر",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'السعر: ${widget.price} جنيه',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    'التخفيض: ${widget.discount}%',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    'بعد الخصم: ${widget.priceAfterDiscount} جنيه',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'بلد المنشأ: ${widget.country}',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          /// الأزرار في الأسفل
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton('تعديل المنتج', Colors.blue, () {
                  // تعديل المنتج
                }),
                _customButton('شراء المنتج', Colors.green, () {
                  // شراء المنتج
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customButton(String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
