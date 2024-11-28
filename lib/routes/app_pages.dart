// lib/routes/app_pages.dart

import 'package:dycare/presentation/appointments/appointment_details/bindings/appointment_details_binding.dart';
import 'package:dycare/presentation/appointments/book_appointment/bindings/book_appointment_binding.dart';
import 'package:dycare/presentation/appointments/my_appointments/bindings/my_appointments_binding.dart';
import 'package:dycare/presentation/appointments/search/bindings/search_bindings.dart';
import 'package:dycare/presentation/appointments/search/search_screen.dart';
import 'package:dycare/presentation/auth/new_user_name/bindings/new_user_name_bindings.dart';
import 'package:dycare/presentation/auth/new_user_name/new_user_name_screen.dart';
import 'package:dycare/presentation/auth/otp/bindings/otp_binding.dart';
import 'package:dycare/presentation/home/bindings/home_binding.dart';
import 'package:dycare/presentation/nurses/nurse_reviews/bindings/nurse_reviews_binding.dart';
import 'package:dycare/presentation/profile/edit_profile/bindings/edit_profile_binding.dart';
import 'package:dycare/presentation/profile/view_profile/bindings/view_profile_binding.dart';
import 'package:get/get.dart';
import 'package:dycare/presentation/auth/login/login_screen.dart';
import 'package:dycare/presentation/auth/login/bindings/login_binding.dart';
import 'package:dycare/presentation/auth/otp/otp_screen.dart';
import 'package:dycare/presentation/home/home_screen.dart';
import 'package:dycare/presentation/appointments/book_appointment/book_appointment_screen.dart';
import 'package:dycare/presentation/appointments/appointment_details/appointment_details_screen.dart';
import 'package:dycare/presentation/appointments/my_appointments/my_appointments_screen.dart';
import 'package:dycare/presentation/nurses/nurse_reviews/nurse_reviews_screen.dart';
import 'package:dycare/presentation/profile/view_profile/view_profile_screen.dart';
import 'package:dycare/presentation/profile/edit_profile/edit_profile_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.NEW_USER_NAME,
      page: () => NewUserNameScreen(),
      binding:NewUserNameBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.BOOK_APPOINTMENT,
      page: () => BookAppointmentScreen(),
      binding: BookAppointmentBinding(),
    ),
    GetPage(
      name: Routes.APPOINTMENT_DETAILS,
      page: () => AppointmentDetailsScreen(),
      binding: AppointmentDetailsBinding(),
    ),
    GetPage(
      name: Routes.MY_APPOINTMENTS,
      page: () => MyAppointmentsScreen(),
      binding: MyAppointmentsBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchScreen(),
      binding: SearchBindings(),
    ),
    GetPage(
      name: Routes.NURSE_REVIEWS,
      page: () => NurseReviewsScreen(),
      binding: NurseReviewsBinding(),
    ),
    GetPage(
      name: Routes.VIEW_PROFILE,
      page: () => ViewProfileScreen(),
      binding: ViewProfileBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
  ];
}