class ApiUrl {
  static const String host = '192.168.1.40:8000';
  static const String baseUrl = 'http://${host}/api/v1';
  // Auth
  static const String signup = '$baseUrl/auth/signup';
  static const String signupGoogle = '$baseUrl/auth/signup/google';
  static const String signin = '$baseUrl/auth/signin';
  static const String signinGoogle = '$baseUrl/auth/signin/google';
  static const String signout = '$baseUrl/auth/signout';
  // User
  static const String currentUser = '$baseUrl/auth/current';
  // Otp
  static const String verificationCode = '$baseUrl/auth/verification';
  static const String resendVerificationCode = '$baseUrl/auth/send-otp';
  // Event
  static const String getCategories = '$baseUrl/event/categories';
  static const String getEvent = '$baseUrl/event';

  // Event Organizer
  static const String createEventOrganizer = '$baseUrl/organizer/register';
  static const String createEvent = '$baseUrl/event';
  static const String getMeEventOrganizer = '$baseUrl/organizer/me';
  static const String getMyEvents = '$baseUrl/organizer/me/events';
  static String updateEventOrganizer(String id) =>
      '$baseUrl/organizer/$id/edit';

  // Profile
  static const String updateProfile = '$baseUrl/user/edit';
}
