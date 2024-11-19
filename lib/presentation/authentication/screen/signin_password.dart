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

class SigninPasswordScreen extends StatelessWidget {
  SigninPasswordScreen({super.key, required this.email});

  final String email;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Show a Snackbar with a welcome message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Welcome, ${state.user.fullName}'),
          ));
          Future.delayed(Duration(seconds: 1), () {
            // Navigate to the Main Menu screen after successful login
            AppNavigator.pushAndRemoveUntil(
              context,
              const MainMenuScreen(),
              (_) => false, // This removes all previous screens from the stack
            );
          });
        }

        if (state is AuthError) {
          // Show a Snackbar with the error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      child: Scaffold(
        appBar: const BasicAppbar(),
        body: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return BasicAppButton(
            onPressed: () {},
            title: 'Continue',
            isLoading: true,
          );
        }
        return BasicAppButton(
          onPressed: () {
            // Dispatch SignInEvent and wait for the AuthBloc to handle the response
            context
                .read<AuthBloc>()
                .add(SignInEvent(email, _passwordController.text));
          },
          title: 'Continue',
        );
      },
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
            // Navigate to forgot password screen
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
