import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:dycare/theme/theme_helper.dart';
import 'package:dycare/core/constants/app_constants.dart';
import 'package:permission_handler/permission_handler.dart';  // Import the permission handler package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Request location permission before running the app
  await _requestPermission();

  // Initialize any services or configurations here
  // For example: await Firebase.initializeApp();
  Get.put<UserRepository>(UserRepositoryImpl());
  Get.put<AppointmentRepository>(AppointmentRepositoryImpl('https://hono-on-vercel-swart-one.vercel.app/api'));

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    print('Detailed error: ${details.exception}');
    print('Stack trace: ${details.stack}');
  };

  runApp(DyCareApp());
}

Future<void> _requestPermission() async {
  var status = await Permission.location.request();
  if (status.isGranted) {
    print("Location permission granted");
    // Proceed with geolocation tasks
  } else {
    print("Location permission denied");
    // Handle permission denial (show a message, guide the user to settings, etc.)
  }
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
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 400),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
