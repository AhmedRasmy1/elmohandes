import 'package:elmohandes/features/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  static const String onBoarding = '/';
  static const String registerView = '/RegisterView';

  static const String loginView = '/LoginView';
  static const String homeView = '/HomeView';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.loginView:
        return MaterialPageRoute(builder: (_) => const LoginPage());
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
