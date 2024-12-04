import 'package:fest_ticketing/common/bloc/authentication/authentication_bloc.dart';
import 'package:fest_ticketing/common/bloc/authentication/authentication_event.dart';
import 'package:fest_ticketing/common/bloc/authentication/authentication_state.dart';
import 'package:fest_ticketing/core/main_menu/screen/main_menu.dart';
import 'package:fest_ticketing/presentation/authentication/screen/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/buttons/basic_app_button.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// signin_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPasswordScreen extends StatefulWidget {
  final String email;

  const SigninPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<SigninPasswordScreen> createState() => _SigninPasswordScreenState();
}

class _SigninPasswordScreenState extends State<SigninPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          _showSuccessMessage(state.user.fullName);
          Future.delayed(const Duration(seconds: 1), () {
            AppNavigator.pushAndRemoveUntil(
              context,
              const MainMenuScreen(),
              (_) => false,
            );
          });
        }

        if (state is AuthError) {
          _showErrorMessage(state.message);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red.shade400,
                    Colors.red.shade800,
                  ],
                ),
              ),
            ),

            // Decorative Elements
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            padding: const EdgeInsets.all(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Header Section
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Almost there!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Enter your password to continue',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    color: Colors.white.withOpacity(0.9),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.email,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Form Container
                      SlideTransition(
                        position: _slideAnimation,
                        child: Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildPasswordField(),
                                const SizedBox(height: 24),
                                _buildSignInButton(),
                                const SizedBox(height: 16),
                                _buildForgotPasswordLink(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.red.shade400),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade600,
              ),
              onPressed: () =>
                  setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
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
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Password must be at least 6 characters long',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<AuthBloc>().add(
                          SignInEvent(widget.email, _passwordController.text),
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
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        );
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          AppNavigator.push(context, ForgotPasswordScreen());
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.red.shade600,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text('Forgot Password?'),
      ),
    );
  }

  void _showSuccessMessage(String fullName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text('Welcome back, $fullName!'),
          ],
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
// class SigninPasswordScreen extends StatelessWidget {
//   SigninPasswordScreen({super.key, required this.email});

//   final String email;
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is Authenticated) {
//           // Show a Snackbar with a welcome message
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Welcome, ${state.user.fullName}'),
//           ));
//           Future.delayed(Duration(seconds: 1), () {
//             // Navigate to the Main Menu screen after successful login
//             AppNavigator.pushAndRemoveUntil(
//               context,
//               const MainMenuScreen(),
//               (_) => false, // This removes all previous screens from the stack
//             );
//           });
//         }

//         if (state is AuthError) {
//           // Show a Snackbar with the error message
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(state.message),
//           ));
//         }
//       },
//       child: Scaffold(
//         appBar: const BasicAppbar(),
//         body: SingleChildScrollView(
//           child: Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildTitle(context),
//                 const SizedBox(height: AppSize.spaceBtwInputFields),
//                 _buildPasswordField(context),
//                 const SizedBox(height: AppSize.spaceBtwInputFields),
//                 _buildButtonContinue(context),
//                 const SizedBox(height: AppSize.spaceBtwInputFields),
//                 _buildForgotPassword(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTitle(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Text(
//       'Sign in',
//       style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//             color: isDark ? AppColor.white : AppColor.black,
//             fontWeight: FontWeight.bold,
//           ),
//     );
//   }

//   Widget _buildPasswordField(BuildContext context) {
//     return TextFormField(
//       controller: _passwordController,
//       decoration: const InputDecoration(hintText: 'Password'),
//     );
//   }

//   Widget _buildButtonContinue(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthLoading) {
//           return BasicAppButton(
//             onPressed: () {},
//             title: 'Continue',
//             isLoading: true,
//           );
//         }
//         return BasicAppButton(
//           onPressed: () {
//             // Dispatch SignInEvent and wait for the AuthBloc to handle the response
//             context
//                 .read<AuthBloc>()
//                 .add(SignInEvent(email, _passwordController.text));
//           },
//           title: 'Continue',
//         );
//       },
//     );
//   }

//   Widget _buildForgotPassword(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           "Forgot password?",
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//         TextButton(
//           onPressed: () {
//             // Navigate to forgot password screen
//             AppNavigator.pushReplacement(context, ForgotPasswordScreen());
//           },
//           child: Text(
//             'Reset password',
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
