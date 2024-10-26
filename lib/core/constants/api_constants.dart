// lib/core/constants/api_constants.dart

class ApiConstants {
  // Base URLs
  static const String BASE_URL = 'https://api.dycare.com/v1'; // Replace with your actual API base URL
  static const String SOCKET_URL = 'wss://socket.dycare.com'; // Replace with your WebSocket URL if applicable

  // Authentication endpoints
  static const String LOGIN = '/auth/login';
  static const String REGISTER = '/auth/register';
  static const String FORGOT_PASSWORD = '/auth/forgot-password';
  static const String RESET_PASSWORD = '/auth/reset-password';
  static const String REFRESH_TOKEN = '/auth/refresh-token';

  // User endpoints
  static const String GET_USER_PROFILE = '/users/profile';
  static const String UPDATE_USER_PROFILE = '/users/profile';
  static const String UPDATE_PROFILE_PICTURE = '/users/profile-picture';

  // Nurse endpoints
  static const String GET_NURSES = '/nurses';
  static const String GET_NURSE_DETAILS = '/nurses/'; // Append nurse ID
  static const String GET_NURSE_REVIEWS = '/nurses/reviews/'; // Append nurse ID

  // Appointment endpoints
  static const String GET_APPOINTMENTS = '/appointments';
  static const String CREATE_APPOINTMENT = '/appointments';
  static const String UPDATE_APPOINTMENT = '/appointments/'; // Append appointment ID
  static const String CANCEL_APPOINTMENT = '/appointments/cancel/'; // Append appointment ID

  // Review endpoints
  static const String CREATE_REVIEW = '/reviews';
  static const String UPDATE_REVIEW = '/reviews/'; // Append review ID
  static const String DELETE_REVIEW = '/reviews/'; // Append review ID

  // Chat endpoints
  static const String GET_CHAT_ROOMS = '/chats';
  static const String GET_CHAT_MESSAGES = '/chats/messages/'; // Append chat room ID
  static const String SEND_MESSAGE = '/chats/messages';

  // API version
  static const String API_VERSION = 'v1';

  // Timeout durations
  static const int CONNECTION_TIMEOUT = 15000; // 15 seconds
  static const int RECEIVE_TIMEOUT = 15000; // 15 seconds

  // Pagination
  static const int DEFAULT_PAGE_SIZE = 20;

  // Headers
  static const String CONTENT_TYPE = 'Content-Type';
  static const String AUTHORIZATION = 'Authorization';

  // Common query parameters
  static const String QUERY_PAGE = 'page';
  static const String QUERY_LIMIT = 'limit';
  static const String QUERY_SEARCH = 'search';

  // Error messages
  static const String ERROR_UNAUTHORIZED = 'Unauthorized access';
  static const String ERROR_TIMEOUT = 'Request timed out';
  static const String ERROR_INTERNET_CONNECTION = 'No internet connection';
  static const String ERROR_SERVER = 'Server error occurred';

  // Success messages
  static const String SUCCESS_LOGIN = 'Login successful';
  static const String SUCCESS_REGISTER = 'Registration successful';
  static const String SUCCESS_PASSWORD_RESET = 'Password reset successful';

  // Function to get full URL for an endpoint
  static String getUrl(String endpoint) {
    return BASE_URL + endpoint;
  }

  // Function to get authorization header
  static Map<String, String> getAuthHeader(String token) {
    return {AUTHORIZATION: 'Bearer $token'};
  }
}