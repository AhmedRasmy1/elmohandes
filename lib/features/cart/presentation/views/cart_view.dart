import 'package:cached_network_image/cached_network_image.dart';
import 'package:elmohandes/features/home/presentation/views/home_page_view.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 600;

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
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
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
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 3 : 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isDesktop ? 1.5 : 1.8,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(cartItems[index]);
                    },
                  );
                },
              ),
            ),
          ),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
          _buildProductImage(product["image"]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product["name"],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text("السعر: ${product["price"]} جنيه",
                    style: const TextStyle(fontSize: 16)),
                Text("الكمية: ${product["quantity"]}",
                    style: const TextStyle(fontSize: 16)),
                Text("الخصم: ${product["discount"]}%",
                    style: const TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // تنفيذ حذف المنتج من السلة
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
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
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          // تنفيذ إنشاء الفاتورة
        },
        child: const Text("إنشاء فاتورة",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }
}

// بيانات المنتجات التجريبية
List<Map<String, dynamic>> cartItems = [
  {
    "name": "منتج 1",
    "price": 100,
    "discount": 10,
    "quantity": 2,
    "image": "assets/images/hafara.jpeg",
  },
  {
    "name": "منتج 2",
    "price": 250,
    "discount": 5,
    "quantity": 1,
    "image": "assets/images/icon.jpg",
  },
  {
    "name": "منتج 3",
    "price": 300,
    "discount": 20,
    "quantity": 3,
    "image": "assets/images/icon.jpg",
  },
  {
    "name": "منتج 4",
    "price": 150,
    "discount": 15,
    "quantity": 2,
    "image": "assets/images/icon.jpg",
  },
];
