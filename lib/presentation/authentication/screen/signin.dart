import 'package:fest_ticketing/presentation/authentication/screen/signup.dart';
import 'package:fest_ticketing/presentation/authentication/screen/signin_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/buttons/basic_app_button.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(hideBack: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png', // Ganti dengan path logo Anda
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
              child: _buildTitle(context),
            ),
            const SizedBox(
                height:
                    AppSize.spaceBtwSections), // Jarak antara judul dan form
            Container(
              padding: const EdgeInsets.all(AppSize.defaultSpace),
              margin:
                  const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 230, 7, 7).withOpacity(0.1)
                    : AppColor.white,
                borderRadius: BorderRadius.circular(AppSize.cardRadiusXl),
                boxShadow: [
                  if (Theme.of(context).brightness != Brightness.dark)
                    BoxShadow(
                      color: AppColor.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                ],
              ),
              child: _buildForm(context),
            ),
            const SizedBox(height: AppSize.spaceBtwSections),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
              child: _buildDoNotHaveAccount(context),
            ),
            const SizedBox(height: AppSize.spaceBtwSections),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
              child: _buildGoogleSignInButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign in',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: isDark ? AppColor.white : AppColor.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Selamat Datang Di FastTicket!',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: isDark
                    ? AppColor.white.withOpacity(0.7)
                    : AppColor.black.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Login atau Register Sekarang untuk menikmati semua fitur yang tersedia di FastTicket',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: isDark
                    ? AppColor.white.withOpacity(0.7)
                    : AppColor.black.withOpacity(0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildEmailField(),
          const SizedBox(height: AppSize.spaceBtwInputFields),
          _buildButtonContinue(context),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email'),
      validator: _validateEmail,
    );
  }

  Widget _buildButtonContinue(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          AppNavigator.push(
            context,
            SigninPasswordScreen(
              email: _emailController.text,
            ),
          );
        }
      },
      title: 'Continue',
    );
  }

  Widget _buildDoNotHaveAccount(BuildContext context) {
    return Row(
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            AppNavigator.pushReplacement(context, SignupScreen());
          },
          child: Text(
            'Create one',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('Sign in with Google');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.buttonRadiusCircular),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/vectors/icons-google.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Sign in with Google',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColor.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
