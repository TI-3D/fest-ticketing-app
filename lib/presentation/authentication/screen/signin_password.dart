import 'package:fest_ticketing/presentation/authentication/screen/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/buttons/basic_app_button.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';

class SigninPasswordScreen extends StatelessWidget {
  SigninPasswordScreen({super.key, required this.email});

  final String email;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildPasswordField(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildButtonContinue(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildForgotPassword(context),
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

  Widget _buildPasswordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _buildButtonContinue(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        // AppNavigator.push(context, Container());
      },
      title: 'Continue',
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Row(
      children: [
        Text(
          "Forgot password?",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            AppNavigator.pushReplacement(context, ForgotPasswordScreen());
          },
          child: Text(
            'Reset password',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.primary),
          ),
        ),
      ],
    );
  }
}
