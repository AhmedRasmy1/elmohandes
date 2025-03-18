import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/di/di.dart';
import 'core/utils/cashed_data_shared_preferences.dart';
import 'core/utils/my_bloc_observer.dart';
import 'features/auth/presentation/views/login_view.dart';
import 'features/home/presentation/views/home_page_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  await CacheService.cacheInitialization();
  configureDependencies();
  Bloc.observer = MyBlocObserver();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const Elmohandes());
  });
}

class Elmohandes extends StatelessWidget {
  const Elmohandes({super.key});

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
      home: const SplashHandler(),
    );
  }
}

class SplashHandler extends StatefulWidget {
  const SplashHandler({super.key});

  @override
  State<SplashHandler> createState() => _SplashHandlerState();
}

class _SplashHandlerState extends State<SplashHandler> {
  @override
  void initState() {
    super.initState();
    navigateAfterSplash();
  }

  Future<void> navigateAfterSplash() async {
    final token = await CacheService.getData(key: CacheConstants.userToken);

    /// بعد ما نحدد وجهة المستخدم، نحذف الـ Splash Screen
    FlutterNativeSplash.remove();

    /// تحويل المستخدم إلى الصفحة المناسبة
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => (token != null && token.isNotEmpty)
            ? const ProductsPage()
            : const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
          Center(child: CircularProgressIndicator()), // شاشة مؤقتة لحين التوجيه
    );
  }
}
