import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mawad/src/data/services/auth_token_service.dart';
import 'package:mawad/src/data/services/localstorage_service.dart';
import 'package:mawad/src/modules/main_binding.dart';
import 'package:mawad/src/presentation/routes/app_pages.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/theme/theme.dart';
import 'package:mawad/src/presentation/appcore/language/localizations.dart'
    as localizations;
import 'package:mawad/src/modules/main.page.dart';

import 'injectable/getit.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorageService();

  await localStorage.initialize();
  final authService = AuthTokenService();
  await authService.initialize();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // Locks app orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  //Setting SysemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.grey.shade200,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.grey.shade500,
      statusBarIconBrightness: Brightness.dark));

  //Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  configureDependencies();
  // Loads contents from .env into memory.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = GetStorage().read('lang');
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        translations: localizations.Localizations(),
        fallbackLocale: const Locale('ar', 'KW'),
        supportedLocales: const [
          Locale('ar', 'KW'), // Spanish
          Locale('en', 'US'), // English
        ],
        locale:
            lang == 'en' ? const Locale('en', 'US') : const Locale('ar', 'KW'),
        theme: LightThemeData,
        // home: const RegisterPage(),
        home: const MainPage(),
        initialRoute: AppRoutes.main,
        initialBinding: MainBinding(),
        getPages: AppPages.pages,
      ),
    );
  }
}
