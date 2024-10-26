// lib/core/constants/app_constants.dart

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