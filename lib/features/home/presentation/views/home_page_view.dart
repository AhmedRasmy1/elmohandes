import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';

import '../../../../core/di/di.dart';
import '../viewmodels/productss/products_cubit.dart';
import 'add_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_details_view.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  late ProductsCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;

    return BlocProvider(
      create: (context) => viewModel..getAllProducts(),
      child: Scaffold(
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
              int crossAxisCount = isDesktop ? 4 : 2;
              return Column(
                children: [
                  Expanded(
                    child: BlocConsumer<ProductsCubit, ProductsState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is ProductsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ProductsSuccess) {
                          final products = state.productsEntity;
                          return RefreshIndicator(
                            onRefresh: () async {
                              viewModel.getAllProducts();
                            },
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: isDesktop ? 1 : 0.8,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    CacheService.setData(
                                        key: CacheConstants.productId,
                                        value: products[index].id);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return ProductDetailsPage(
                                        productName:
                                            products[index].productName,
                                        price: products[index].price,
                                        discount: products[index].discount,
                                        image: products[index].imageUrl,
                                        country:
                                            products[index].countryOfOrigin,
                                      );
                                    }));
                                  },
                                  child: Center(
                                      child: ProductCard(
                                          productName:
                                              products[index].productName,
                                          image: products[index].imageUrl,
                                          price: products[index].price,
                                          discount: products[index].discount,
                                          countryOfRigion:
                                              products[index].countryOfOrigin,
                                          isDesktop: isDesktop)),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('لا يوجد منتجات'),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: isDesktop ? 250 : double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const AddProduct();
                          }));
                        },
                        child: const Text(
                          'إضافة منتج',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final bool isDesktop;
  final String? productName;
  final String? image;
  final num? price;
  final num? discount;

  num get calculatedPriceAfterDiscount {
    if (price != null && discount != null) {
      return price! - (price! * discount! / 100);
    }
    return 0;
  }

  final String? countryOfRigion;
  const ProductCard({
    super.key,
    required this.isDesktop,
    this.productName,
    this.image,
    this.price,
    this.discount,
    this.countryOfRigion,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth;
        double fontSizeTitle = isDesktop ? 18 : 16;
        double fontSizeText = isDesktop ? 14 : 12;

        return Container(
          width: containerWidth,
          decoration: BoxDecoration(
            color: const Color(0xfff5f5f5),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Container(
                  width: containerWidth * 0.5,
                  height: containerWidth * 0.5,
                  constraints: const BoxConstraints(
                    minWidth: 100,
                    minHeight: 100,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: image != null
                      ? Image.network(
                          image!,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 10),
              FittedBox(
                child: Text(
                  'اسم المنتج: $productName',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Text(
                  'السعر: $price جنيه',
                  style: TextStyle(color: Colors.black, fontSize: fontSizeText),
                ),
              ),
              FittedBox(
                child: Text(
                  'التخفيض: $discount%',
                  style: TextStyle(color: Colors.black, fontSize: fontSizeText),
                ),
              ),
              FittedBox(
                child: Text(
                  'بعد الخصم: ${calculatedPriceAfterDiscount.toStringAsFixed(2)} جنيه',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSizeText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Text(
                  'بلد المنشأ: $countryOfRigion',
                  style: TextStyle(color: Colors.black, fontSize: fontSizeText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
