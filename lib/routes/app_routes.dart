// lib/routes/app_routes.dart

part of 'app_pages.dart';

abstract class Routes {
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const OTP = '/otp';
  static const RESET_PASSWORD = '/reset-password';
  static const HOME = '/home';
  static const BOOK_APPOINTMENT = '/book-appointment';
  static const APPOINTMENT_DETAILS = '/appointment-details';
  static const MY_APPOINTMENTS = '/my-appointments';
  static const NURSE_LIST = '/nurse-list';
  static const NURSE_DETAILS = '/nurse-details';
  static const NURSE_REVIEWS = '/nurse-reviews';
  static const CHAT_LIST = '/chat-list';
  static const CHAT_DETAIL = '/chat-detail';
  static const AUDIO_CALL = '/audio-call';
  static const VIDEO_CALL = '/video-call';
  static const VIEW_PROFILE = '/view-profile';
  static const EDIT_PROFILE = '/edit-profile';

  static String ADD_REVIEW = '/add-review';
}