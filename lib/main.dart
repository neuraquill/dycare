import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:dycare/theme/theme_helper.dart';
import 'package:dycare/core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize any services or configurations here
  // For example: await Firebase.initializeApp();

  runApp(DyCareApp());
}

class DyCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.APP_NAME,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeHelper.lightTheme,
      darkTheme: ThemeHelper.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
