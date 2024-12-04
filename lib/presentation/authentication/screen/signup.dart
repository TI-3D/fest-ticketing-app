import 'package:fest_ticketing/presentation/authentication/screen/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/common/widgets/appbar/app_bar.dart';
import 'package:fest_ticketing/common/widgets/buttons/basic_app_button.dart';
import 'package:fest_ticketing/core/constant/color.dart';
import 'package:fest_ticketing/core/constant/size.dart';

enum Gender { MALE, FEMALE }

// class SignupScreen extends StatefulWidget {
//   SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Gender? _selectedGender;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const BasicAppbar(hideBack: false),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildTitle(context),
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildFullNameField(context),
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildEmailField(context),
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildPasswordField(context),
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildGenderButton(context), // Button to open gender selection
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildButtonContinue(context),
//               const SizedBox(height: AppSize.spaceBtwInputFields),
//               _buildAlreadyHave(context),
//               const SizedBox(height: AppSize.spaceBtwSections),
//               _buildGoogleSignInButton(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTitle(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Text(
//       'Sign up',
//       style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//             color: isDark ? AppColor.white : AppColor.black,
//             fontWeight: FontWeight.bold,
//           ),
//     );
//   }

//   Widget _buildFullNameField(BuildContext context) {
//     return TextFormField(
//       controller: _fullNameController,
//       decoration: const InputDecoration(hintText: 'Full Name'),
//     );
//   }

//   Widget _buildEmailField(BuildContext context) {
//     return TextFormField(
//       controller: _emailController,
//       decoration: const InputDecoration(hintText: 'Email'),
//     );
//   }

//   Widget _buildPasswordField(BuildContext context) {
//     return TextFormField(
//       controller: _passwordController,
//       decoration: const InputDecoration(hintText: 'Password'),
//       obscureText: true,
//     );
//   }

//   Widget _buildGenderButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showGenderSelection(context),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//         decoration: BoxDecoration(
//           color: AppColor.grey.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(AppSize.buttonRadius),
//         ),
//         child: Row(
//           children: [
//             Text(
//               _selectedGender == null
//                   ? 'Select Gender'
//                   : _selectedGender == Gender.MALE
//                       ? 'Male'
//                       : 'Female',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showGenderSelection(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: const Text('Male'),
//                 onTap: () {
//                   setState(() {
//                     _selectedGender = Gender.MALE;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text('Female'),
//                 onTap: () {
//                   setState(() {
//                     _selectedGender = Gender.FEMALE;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
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

//   Widget _buildAlreadyHave(BuildContext context) {
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

//   Widget _buildGoogleSignInButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         print('Sign up with Google');
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
//               'Sign up with Google',
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
class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Gender? _selectedGender;
  bool _isPasswordVisible = false;

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
                    Center(
                      child: Hero(
                        tag: 'app_logo',
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Create Account',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join FastTicket and discover amazing events',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ),
                    const SizedBox(height: 32),
                    // Form Container
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
                            _buildFormField(
                              controller: _fullNameController,
                              label: 'Full Name',
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            _buildFormField(
                              controller: _emailController,
                              label: 'Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your email';
                                }
                                // Add email validation
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            _buildPasswordField(),
                            const SizedBox(height: 20),
                            _buildGenderSelector(),
                            const SizedBox(height: 24),
                            _buildSignUpButton(),
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 20),
                            _buildGoogleSignUpButton(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSignInLink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.red.shade400),
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
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock_outline, color: Colors.red.shade400),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
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
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showGenderSelection(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.person_outline, color: Colors.red.shade400),
              const SizedBox(width: 12),
              Text(
                _selectedGender == null
                    ? 'Select Gender'
                    : _selectedGender == Gender.MALE
                        ? 'Male'
                        : 'Female',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey.shade600),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // Handle sign up
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
        'Create Account',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGoogleSignUpButton() {
    return OutlinedButton.icon(
      onPressed: () {
        // Handle Google Sign Up
      },
      icon: SvgPicture.asset(
        'assets/vectors/icons-google.svg',
        width: 24,
        height: 24,
      ),
      label: const Text('Sign up with Google'),
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

  Widget _buildSignInLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
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

  void _showGenderSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Gender',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              _buildGenderOption(Gender.MALE, 'Male', Icons.male),
              const SizedBox(height: 8),
              _buildGenderOption(Gender.FEMALE, 'Female', Icons.female),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenderOption(Gender gender, String label, IconData icon) {
    final isSelected = _selectedGender == gender;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.red.shade400 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.red.shade400 : Colors.grey.shade600,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.red.shade400 : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected) ...[
              const Spacer(),
              Icon(Icons.check_circle, color: Colors.red.shade400),
            ],
          ],
        ),
      ),
    );
  }
}
