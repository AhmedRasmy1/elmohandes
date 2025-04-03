import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../auth/presentation/views/login_view.dart';
import '../../../cart/presentation/view_models/cart_display/cart_details_cubit.dart';
import '../../../cart/presentation/views/cart_view.dart';
import '../../../invoice/presentation/views/display_all_invoices.dart';

import '../../../../core/utils/cashed_data_shared_preferences.dart';
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
  late ProductsCubit viewModel;
  late CartDetailsCubit cartDetailsCubit;
  // late bool isAdmin;

  @override
  void initState() {
    viewModel = getIt.get<ProductsCubit>();
    cartDetailsCubit = getIt.get<CartDetailsCubit>();
    // String? token = CacheService.getData(key: CacheConstants.userToken);
    // if (token != null) {
    //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    //   isAdmin = decodedToken['roles'] != null &&
    //       decodedToken['roles'].contains("Admin");
    // } else {
    //   isAdmin = false;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => viewModel..getAllProducts(),
        ),
        BlocProvider(
          create: (context) => cartDetailsCubit..getCartDetails(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              tooltip: 'تسجيل الخروج',
              onPressed: () {
                final screenWidth = MediaQuery.of(context).size.width;
                final dialogWidth = screenWidth > 600 ? 500.0 : null;
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.bottomSlide,
                  title: 'تأكيد تسجيل الخروج',
                  desc: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                  btnCancelText: 'لا',
                  btnOkText: 'نعم',
                  width: dialogWidth,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    CacheService.clearItems();
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }), (route) => false);
                  },
                ).show();
              },
            ),
          ],
          leading: BlocBuilder<CartDetailsCubit, CartDetailsState>(
            builder: (context, state) {
              var data = state;
              if (data is CartDetailsSuccess) {
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.blue),
                      tooltip: 'عرض السلة',
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const CartPage();
                        }));
                      },
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: BlocBuilder<CartDetailsCubit, CartDetailsState>(
                          builder: (context, state) {
                            if (state is CartDetailsSuccess) {
                              return Text(
                                state.cartDetails.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              );
                            }
                            return const Text(
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
              return IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.blue),
                tooltip: 'عرض السلة',
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const CartPage();
                  }));
                },
              );
            },
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'المهندس',
            style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'ArefRuqaa'),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
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
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount =
                                constraints.maxWidth > 600 ? 4 : 2;

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.75,
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
                                        id: products[index].id,
                                        productName:
                                            products[index].productName,
                                        price: products[index].price,
                                        discount: products[index].discount,
                                        image: products[index].imageUrl,
                                        country:
                                            products[index].countryOfOrigin,
                                        quantity: products[index].quantity,
                                      );
                                    }));
                                  },
                                  child: ProductCard(
                                    productName: products[index].productName,
                                    image: products[index].imageUrl,
                                  ),
                                );
                              },
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) {
                              return const AddProduct();
                            },
                          )).then((value) {
                            if (value != null && value) {
                              viewModel.getAllProducts();
                            }
                          });
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
                    const SizedBox(width: 10),
                    // if (isAdmin)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) {
                              return const InvoicesView();
                            },
                          ));
                        },
                        child: const Text(
                          'عرض الفواتير',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String? productName;
  final String? image;

  const ProductCard({
    super.key,
    this.productName,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image != null
                    ? CachedNetworkImage(
                        imageUrl: image!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported, size: 50),
                      )
                    : const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            productName ?? 'منتج بدون اسم',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
