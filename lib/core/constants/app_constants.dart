// lib/core/constants/app_constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String APP_NAME = 'DyCare';
  static const String APP_VERSION = '1.0.0';
  
  // API Versions
  static const String API_VERSION = 'v1';

  // Shared Preferences Keys
  static const String TOKEN_KEY = 'auth_token';
  static const String USER_ID_KEY = 'user_id';
  static const String USER_TYPE_KEY = 'user_type';

  // User Types
  static const String USER_TYPE_PATIENT = 'patient';
  static const String USER_TYPE_NURSE = 'nurse';

  // Screen Titles
  static const String LOGIN_TITLE = 'Login';
  static const String SIGNUP_TITLE = 'Sign Up';
  static const String FORGOT_PASSWORD_TITLE = 'Forgot Password';
  static const String RESET_PASSWORD_TITLE = 'Reset Password';
  static const String HOME_TITLE = 'Home';
  static const String BOOK_APPOINTMENT_TITLE = 'Book Appointment';
  static const String MY_APPOINTMENTS_TITLE = 'My Appointments';
  static const String NURSE_LIST_TITLE = 'Nurses';
  static const String CHAT_LIST_TITLE = 'Chats';
  static const String PROFILE_TITLE = 'Profile';

  // Theme Specifications
  // Colors
  static const Color primary = Colors.black;
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color accentPink = Color(0xFFFFE4E6);
  static const Color accentBlue = Color(0xFF2196F3);
  static const Color available = Color(0xFF4CAF50);
  static const Color booked = Color(0xFFE0E0E0);

  // Typography
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textSecondary,
  );

  // Spacing and Dimensions
  static const double standardPadding = 16.0;
  static const double contentPadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const double iconSize = 24.0;
  static const double inputFieldHeight = 48.0;

  // Component Styles
  // Buttons
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  );

  static final ButtonStyle secondaryButton = OutlinedButton.styleFrom(
    foregroundColor: primary,
    side: const BorderSide(color: primary),
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  );

  // Input Fields
  static final InputDecoration searchDecoration = InputDecoration(
    filled: true,
    fillColor: background,
    hintStyle: bodyMedium,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide.none,
    ),
  );

  static final InputDecoration textFieldDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: textSecondary),
    ),
  );

  // Cards
  static final CardTheme cardTheme = CardTheme(
    elevation: cardElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    color: surface,
  );

  // Error Messages
  static const String NETWORK_ERROR = 'Network error. Please try again.';
  static const String UNKNOWN_ERROR = 'An unknown error occurred. Please try again.';

  // Success Messages
  static const String LOGIN_SUCCESS = 'Login successful!';
  static const String SIGNUP_SUCCESS = 'Sign up successful!';
  static const String PASSWORD_RESET_SUCCESS = 'Password reset successful!';

  // Validation Messages
  static const String INVALID_EMAIL = 'Please enter a valid email address.';
  static const String INVALID_PASSWORD = 'Password must be at least 8 characters long.';
  static const String PASSWORDS_DO_NOT_MATCH = 'Passwords do not match.';

  // Button Text
  static const String LOGIN_BUTTON = 'Login';
  static const String SIGNUP_BUTTON = 'Sign Up';
  static const String FORGOT_PASSWORD_BUTTON = 'Forgot Password?';
  static const String RESET_PASSWORD_BUTTON = 'Reset Password';
  static const String BOOK_APPOINTMENT_BUTTON = 'Book Appointment';

  // Placeholder Text
  static const String EMAIL_PLACEHOLDER = 'Enter your email';
  static const String PASSWORD_PLACEHOLDER = 'Enter your password';
  static const String CONFIRM_PASSWORD_PLACEHOLDER = 'Confirm your password';

  // Date Formats
  static const String DATE_FORMAT = 'yyyy-MM-dd';
  static const String TIME_FORMAT = 'HH:mm';
  static const String DATE_TIME_FORMAT = 'yyyy-MM-dd HH:mm';

  // Pagination
  static const int DEFAULT_PAGE_SIZE = 20;

  // Timeouts
  static const int CONNECTION_TIMEOUT = 30000; // 30 seconds
  static const int RECEIVE_TIMEOUT = 30000; // 30 seconds

  // File Paths
  static const String PROFILE_IMAGES_PATH = 'assets/images/profiles/';
  static const String NURSE_IMAGES_PATH = 'assets/images/nurses/';

  // Other Constants
  static const int MAX_LOGIN_ATTEMPTS = 5;
  static const int OTP_EXPIRATION_MINUTES = 5;
  static const int PASSWORD_MIN_LENGTH = 8;
}
