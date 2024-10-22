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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(hideBack: true),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildEmailField(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildButtonContinue(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildDoNotHaveAccount(context),
              const SizedBox(height: AppSize.spaceBtwSections),
              _buildGoogleSignInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      'Sign in',
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: isDark ? AppColor.white : AppColor.black,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _buildButtonContinue(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        AppNavigator.push(context, SigninPasswordScreen(email: ""));
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
        backgroundColor: AppColor.grey.withOpacity(0.1), // Background color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppSize.buttonRadiusCircular), // Pill shape
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        minimumSize:
            const Size(double.infinity, 50), // Full width, min height 50
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
            const SizedBox(width: 8), // Space between icon and text
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
