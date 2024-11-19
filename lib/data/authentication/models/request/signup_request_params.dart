import 'package:fest_ticketing/presentation/authentication/screen/signup.dart';

class SignupRequestParams {
  final String email;
  final String password;
  final String fullName;
  final Gender gender;

  SignupRequestParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.gender
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'full_name': fullName,
      'gender': gender,
    };
  }
}