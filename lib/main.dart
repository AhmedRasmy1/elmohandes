import 'package:bloc/bloc.dart';
import 'package:elmohandes/core/di/di.dart';
import 'package:elmohandes/core/resources/routes_manager.dart';
import 'package:elmohandes/core/utils/cashed_data_shared_preferences.dart';
import 'package:elmohandes/core/utils/my_bloc_observer.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.cacheInitialization();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const Elmohandes());
}

class Elmohandes extends StatelessWidget {
  const Elmohandes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: RoutesManager.loginView,
    );
  }
}
