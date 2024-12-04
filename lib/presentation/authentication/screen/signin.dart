import 'package:fest_ticketing/presentation/authentication/screen/signup.dart';
import 'package:fest_ticketing/presentation/authentication/screen/signin_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/buttons/basic_app_button.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';

// signin_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background Gradient
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

          // Decorative Pattern
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

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Animated Logo
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Hero(
                          tag: 'app_logo',
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.9),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 120,
                              height: 120,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Welcome Text
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Welcome to FastTicket',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your one-stop destination for all event tickets',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                            textAlign: TextAlign.center,
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
                            children: [
                              _buildEmailField(),
                              const SizedBox(height: 24),
                              _buildContinueButton(context),
                              const SizedBox(height: 24),
                              _buildDivider(),
                              const SizedBox(height: 24),
                              _buildGoogleSignInButton(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Create Account Link
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildCreateAccountLink(context),
                    ),
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
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.email_outlined, color: Colors.red.shade400),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear, color: Colors.grey.shade600),
          onPressed: () => _emailController.clear(),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: _validateEmail,
      onChanged: (value) {
        setState(() {}); // Rebuild to update the clear button visibility
      },
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // Show success animation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Email verified successfully!'),
                ],
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          // Navigate to password screen
          Future.delayed(Duration(seconds: 1), () {
            AppNavigator.push(
              context,
              SigninPasswordScreen(email: _emailController.text),
            );
          });
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
      child: const Text(
        'Continue',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        // Add Google Sign In logic
      },
      icon: SvgPicture.asset(
        'assets/vectors/icons-google.svg',
        width: 24,
        height: 24,
      ),
      label: const Text(
        'Continue with Google',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }

  Widget _buildCreateAccountLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: () =>
              AppNavigator.pushReplacement(context, SignupScreen()),
          child: const Text(
            'Create one',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
// class SigninScreen extends StatelessWidget {
//   SigninScreen({super.key});

//   final TextEditingController _emailController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter an email';
//     }
//     String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
//     RegExp regex = RegExp(pattern);
//     if (!regex.hasMatch(value)) {
//       return 'Enter a valid email address';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const BasicAppbar(hideBack: false),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/images/logo.png', // Ganti dengan path logo Anda
//                 width: 200,
//                 height: 200,
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
//               child: _buildTitle(context),
//             ),
//             const SizedBox(
//                 height:
//                     AppSize.spaceBtwSections), // Jarak antara judul dan form
//             Container(
//               padding: const EdgeInsets.all(AppSize.defaultSpace),
//               margin:
//                   const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).brightness == Brightness.dark
//                     ? const Color.fromARGB(255, 230, 7, 7).withOpacity(0.1)
//                     : AppColor.white,
//                 borderRadius: BorderRadius.circular(AppSize.cardRadiusXl),
//                 boxShadow: [
//                   if (Theme.of(context).brightness != Brightness.dark)
//                     BoxShadow(
//                       color: AppColor.grey.withOpacity(0.2),
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                 ],
//               ),
//               child: _buildForm(context),
//             ),
//             const SizedBox(height: AppSize.spaceBtwSections),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
//               child: _buildDoNotHaveAccount(context),
//             ),
//             const SizedBox(height: AppSize.spaceBtwSections),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
//               child: _buildGoogleSignInButton(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTitle(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Sign in',
//           style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//                 color: isDark ? AppColor.white : AppColor.black,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'Selamat Datang Di FastTicket!',
//           style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                 color: isDark
//                     ? AppColor.white.withOpacity(0.7)
//                     : AppColor.black.withOpacity(0.7),
//               ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           'Login atau Register Sekarang untuk menikmati semua fitur yang tersedia di FastTicket',
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 color: isDark
//                     ? AppColor.white.withOpacity(0.7)
//                     : AppColor.black.withOpacity(0.7),
//               ),
//         ),
//       ],
//     );
//   }

//   Widget _buildForm(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           _buildEmailField(),
//           const SizedBox(height: AppSize.spaceBtwInputFields),
//           _buildButtonContinue(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmailField() {
//     return TextFormField(
//       controller: _emailController,
//       decoration: const InputDecoration(hintText: 'Email'),
//       validator: _validateEmail,
//     );
//   }

//   Widget _buildButtonContinue(BuildContext context) {
//     return BasicAppButton(
//       onPressed: () {
//         if (_formKey.currentState?.validate() ?? false) {
//           AppNavigator.push(
//             context,
//             SigninPasswordScreen(
//               email: _emailController.text,
//             ),
//           );
//         }
//       },
//       title: 'Continue',
//     );
//   }

//   Widget _buildDoNotHaveAccount(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           "Don't have an account?",
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//         TextButton(
//           onPressed: () {
//             AppNavigator.pushReplacement(context, SignupScreen());
//           },
//           child: Text(
//             'Create one',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium!
//                 .copyWith(color: AppColor.primary),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGoogleSignInButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         print('Sign in with Google');
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColor.grey.withOpacity(0.1),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppSize.buttonRadiusCircular),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         minimumSize: const Size(double.infinity, 50),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               'assets/vectors/icons-google.svg',
//               width: 24,
//               height: 24,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               'Sign in with Google',
//               style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                     color: AppColor.black,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
