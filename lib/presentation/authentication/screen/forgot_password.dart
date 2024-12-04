import 'package:fest_ticketing/presentation/authentication/screen/signin.dart';
import 'package:fest_ticketing/presentation/authentication/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/buttons/basic_app_button.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   ForgotPasswordScreen({super.key});

//   final TextEditingController _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const BasicAppbar(hideBack: true),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildTitle(context),
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildEmailField(context),
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildButtonContinue(context),
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildAlreadyHave(context)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTitle(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Text(
//       'Forgot Password',
//       style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//             color: isDark ? AppColor.white : AppColor.black,
//             fontWeight: FontWeight.bold,
//           ),
//     );
//   }

//   Widget _buildEmailField(BuildContext context) {
//     return TextFormField(
//       controller: _emailController,
//       decoration: const InputDecoration(hintText: 'Email'),
//     );
//   }

//   Widget _buildButtonContinue(BuildContext context) {
//     return BasicAppButton(
//       onPressed: () {
//         // AppNavigator.push(context, Container());
//       },
//       title: 'Continue',
//     );
//   }

//     Widget _buildAlreadyHave(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           "Already have an account?",
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//         TextButton(
//           onPressed: () {
//             AppNavigator.pushReplacement(context, SigninScreen());
//           },
//           child: Text(
//             'Sign in',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium!
//                 .copyWith(color: AppColor.primary),
//           ),
//         ),
//       ],
//     );
//   }

// }

// forgot_password_screen.dart
class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.red.shade800,
                  Colors.red.shade400,
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Title and description
                    Text(
                      'Reset Password',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Enter your email address and well send you instructions to reset your password.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ),
                    const SizedBox(height: 40),
                    // Form container
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildEmailField(),
                            const SizedBox(height: 24),
                            _buildResetButton(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildBackToSignIn(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter your registered email',
        prefixIcon: Icon(Icons.email_outlined, color: Colors.red.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter your email';
        }
        // Add email validation
        String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(value!)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: _isLoading
          ? null
          : () async {
              if (_formKey.currentState?.validate() ?? false) {
                setState(() {
                  _isLoading = true;
                });

                // Simulate API call
                await Future.delayed(const Duration(seconds: 2));

                setState(() {
                  _isLoading = false;
                });

                // Show success dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text('Check Your Email'),
                    content: Text(
                      'We have sent password reset instructions to ${_emailController.text}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back to previous screen
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 50),
        elevation: 2,
      ),
      child: _isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget _buildBackToSignIn() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Remember your password? ',
            style: TextStyle(color: Colors.white.withOpacity(0.9)),
          ),
          TextButton(
            onPressed: () {
              AppNavigator.pushReplacement(context, SigninScreen());
            },
            child: const Text(
              'Sign in',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
