import 'package:elmohandes/features/auth/presentation/views/login_view.dart';
import 'package:elmohandes/features/home/presentation/views/home_page_view.dart';
import 'package:elmohandes/features/home/presentation/views/product_details_view.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  static const String onBoarding = '/';
  static const String productDetailsPage = '/ProductDetailsPage';
  static const String loginView = '/LoginView';
  static const String productsPage = '/ProductsPage';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.loginView:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RoutesManager.productsPage:
        return MaterialPageRoute(builder: (_) => ProductsPage());
      case RoutesManager.productDetailsPage:
        return MaterialPageRoute(builder: (_) => ProductDetailsPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: const Center(child: Text("No Route Found")),
            ));
  }
}
