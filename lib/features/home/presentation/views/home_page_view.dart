import 'package:elmohandes/core/resources/assets_manager.dart';
import 'package:elmohandes/features/home/presentation/views/product_details_view.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.receipt_long, color: Colors.black),
          onPressed: () {},
        ),
        centerTitle: true,
        title: isSearching
            ? TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'ابحث عن منتج...',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              )
            : const Text(
                'المهندس',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search,
                color: Colors.black),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProductDetailsPage(
                          productName: 'حفارة',
                          price: 200,
                          discount: 20,
                          priceAfterDiscount: 160,
                          image: 'assets/images/hafara.jpeg',
                          country: 'مصر',
                        );
                      }));
                    },
                    child: ProductCard());
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 400;
        double containerWidth = isDesktop ? 250 : double.infinity;
        double imageSize = isDesktop ? 100 : 80;

        return Container(
          width: containerWidth,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: imageSize,
                width: imageSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.image, size: 50, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              const Text(
                'اسم المنتج',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'السعر: 200 جنيه',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const Text(
                'التخفيض: 20%',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const Text(
                'بعد الخصم: 160 جنيه',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'بلد المنشأ: مصر',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
