import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/di/di.dart';
import '../../domain/entities/cart_details_entity.dart';
import '../view_models/cart_display/cart_details_cubit.dart';
import '../view_models/delete_from_cart/delete_cart_product_cubit.dart';
import '../../../home/presentation/views/home_page_view.dart';
import '../../../orders/presentation/views/add_Invoice_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartDetailsCubit viewModel;
  late DeleteCartProductCubit deleteCartProductCubit;

  @override
  void initState() {
    viewModel = getIt.get<CartDetailsCubit>();
    deleteCartProductCubit = getIt.get<DeleteCartProductCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 600;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => viewModel..getCartDetails(),
        ),
        BlocProvider(
          create: (context) => deleteCartProductCubit,
        ),
      ],
      child: BlocBuilder<CartDetailsCubit, CartDetailsState>(
        builder: (context, state) {
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
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
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
                        if (state is CartDetailsLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is CartDetailsSuccess) {
                          final cartDetails = state.cartDetails;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isDesktop ? 3 : 1,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: isDesktop ? 1.5 : 1.8,
                            ),
                            itemCount: cartDetails.length,
                            itemBuilder: (context, index) {
                              return _buildCartItem(
                                  cartDetails[index], context, viewModel);
                            },
                          );
                        }
                        if (state is CartDetailsFailure) {
                          return Center(
                            child: Text('حدث خطأ ما'),
                          );
                        }
                        return Center(
                          child: Text('لا يوجد منتجات في السلة'),
                        );
                      },
                    ),
                  ),
                ),
                _buildCheckoutButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartItem(CartDetailsEntity cartDetails, BuildContext context,
      CartDetailsCubit viewModel) {
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
          _buildProductImage(
            cartDetails.imageUrl!,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cartDetails.productName!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text("السعر: ${cartDetails.price}",
                    style: TextStyle(fontSize: 16)),
                Text("الكمية: ${cartDetails.quantity}",
                    style: TextStyle(fontSize: 16)),
                Text("الخصم: ${cartDetails.discount}%",
                    style: TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              if (cartDetails.productId != null) {
                deleteCartProductCubit
                    .deleteProductFromCart(cartDetails.productId!)
                    .then((_) {
                  setState(() {
                    viewModel.getCartDetails();
                  });
                });
              } else {
                log("Error: Product ID is null!");
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildProductImage(
    String productImage,
  ) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: productImage, // صورة افتراضية
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddInvoiceView();
          }));
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
