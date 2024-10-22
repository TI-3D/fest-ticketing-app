import 'package:fest_ticketing/presentation/authentication/screen/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/buttons/basic_app_button.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';

enum Gender { MALE, FEMALE }

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Gender? _selectedGender;

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
              _buildFullNameField(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildEmailField(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildPasswordField(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildGenderButton(context), // Button to open gender selection
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildButtonContinue(context),
              const SizedBox(height: AppSize.spaceBtwInputFields),
              _buildAlreadyHave(context),
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
      'Sign up',
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: isDark ? AppColor.white : AppColor.black,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildFullNameField(BuildContext context) {
    return TextFormField(
      controller: _fullNameController,
      decoration: const InputDecoration(hintText: 'Full Name'),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Password'),
      obscureText: true,
    );
  }

  Widget _buildGenderButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showGenderSelection(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSize.buttonRadius),
        ),
        child: Row(
          children: [
            Text(
              _selectedGender == null
                  ? 'Select Gender'
                  : _selectedGender == Gender.MALE
                      ? 'Male'
                      : 'Female',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _showGenderSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Male'),
                onTap: () {
                  setState(() {
                    _selectedGender = Gender.MALE;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Female'),
                onTap: () {
                  setState(() {
                    _selectedGender = Gender.FEMALE;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
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

  Widget _buildAlreadyHave(BuildContext context) {
    return Row(
      children: [
        Text(
          "Already have an account?",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            AppNavigator.pushReplacement(context, SigninScreen());
          },
          child: Text(
            'Sign in',
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
        print('Sign up with Google');
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
              'Sign up with Google',
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
