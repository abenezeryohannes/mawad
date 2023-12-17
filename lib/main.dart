import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mawad/src/data/services/auth_token_service.dart';
import 'package:mawad/src/data/services/localstorage_service.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/main.page.dart';
import 'package:mawad/src/modules/main_binding.dart';
import 'package:mawad/src/modules/splash_screen.dart';
import 'package:mawad/src/presentation/routes/app_pages.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/theme/theme.dart';

import 'injectable/getit.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorageService();

  await localStorage.initialize();
  final authService = AuthTokenService();
  await authService.initialize();

  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await LocalStorageService().initialize();
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
    Get.put(() => RegisterWithPhoneController());
    final lang = GetStorage().read('lang');
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      child: FutureBuilder<bool>(
        future: isFirstInstall(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: const SplashScreen(),
                  initialBinding: MainBinding(),
                  getPages: AppPages.pages,
                  theme: LightThemeData);
            } else {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: const MainPage(),
                initialRoute: AppRoutes.main,
                initialBinding: MainBinding(),
                getPages: AppPages.pages,
                theme: LightThemeData,
              );
            }
          } else {
            // Loading indicator or splash screen while checking the first install
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> isFirstInstall() async {
    bool isFirstInstall = LocalStorageService().getInt('first_install') == null;
    if (isFirstInstall) {
      LocalStorageService().saveInt('first_install', 1);
    }
    return isFirstInstall;
  }
}
