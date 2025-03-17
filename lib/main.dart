import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/di/di.dart';
import 'core/resources/routes_manager.dart';
import 'core/utils/cashed_data_shared_preferences.dart';
import 'core/utils/my_bloc_observer.dart';

Future<String> getInitialRoute() async {
  final token = await CacheService.getData(key: CacheConstants.userToken);
  return (token != null && token.isNotEmpty)
      ? RoutesManager.productsPage
      : RoutesManager.loginView;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.cacheInitialization();
  configureDependencies();
  Bloc.observer = MyBlocObserver();

  final initialRoute = await getInitialRoute();
  runApp(Elmohandes(initialRoute: initialRoute));
}

class Elmohandes extends StatelessWidget {
  final String initialRoute;
  const Elmohandes({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: initialRoute,
    );
  }
}
