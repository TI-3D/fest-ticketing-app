import 'dart:async';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_failed.dart';
import 'package:fest_ticketing/common/widgets/snackbar/snackbar_success.dart';
import 'package:fest_ticketing/features/authentication/domain/usecase/verification_code.dart';
import 'package:fest_ticketing/features/liveness_detection/presentation/pages/start_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_ticketing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fest_ticketing/features/authentication/presentation/pages/signin.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;
  String hash;
  bool _isRequestInProgress = false;

  VerificationCodeScreen({
    super.key,
    required this.hash,
    required this.email,
  });

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _focusNodes;
  late Timer _timer;
  int _remainingTime = 180;
  bool _isResendEnabled = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
    _startTimer();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        _timer.cancel();
      }
    });
  }

  String _formatRemainingTime(int remainingTime) {
    int minutes = remainingTime ~/ 60;
    int seconds = remainingTime % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _debounceVerify() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(seconds: 1), () {
      final otp = _otpControllers.map((controller) => controller.text).join();
      if (otp.length == 6) {
        context.read<AuthBloc>().add(
              AuthVerificationCodeEvent(
                VerificationCodeRequestParams(
                  email: widget.email,
                  otp: otp,
                  hash: widget.hash,
                ),
              ),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisteredUncompleted) {
            ScaffoldMessenger.of(context).showSnackBar(
                SuccessSnackBar(message: 'Verification successful.'));
            AppNavigator.pushReplacement(context, StartRegister());
          }

          if (state is AuthVerificationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              FailedSnackBar(message: state.message),
            );
          }
        },
        child: Stack(
          children: [
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

            Positioned(
              top: 100,
              right: -50,
              child: Hero(
                tag: 'decorative_pattern',
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),

            // Content Area
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // App Logo in the Center
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

                      // Title Text
                      Text(
                        'Verification Code',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter the verification code sent to your email.',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                      ),
                      const SizedBox(height: 32),

                      // OTP Input Fields Container
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
                        child: Column(
                          children: [
                            _buildOtpFields(),
                            const SizedBox(height: 20),
                            _buildVerifyButton(),
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 20),
                            _buildResendCodeButton(),
                          ],
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
      ),
    );
  }

  // Build OTP input fields
  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 40,
          child: TextFormField(
            controller: _otpControllers[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            textAlign: TextAlign.center,
            focusNode: _focusNodes[index],
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red.shade400, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red.shade400, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
            ),
            onChanged: (value) {
              // handle value not number
              if (value.isNotEmpty && !RegExp(r'[0-9]').hasMatch(value)) {
                _otpControllers[index].text = '';
                return;
              }
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }

  // Verify button (Verify OTP logic)
  Widget _buildVerifyButton() {
    return ElevatedButton(
      onPressed: () {
        // Call debounceVerify method when the button is clicked
        _debounceVerify();
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
      child: Text(
        'Verify Code',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Resend code button with countdown
  Widget _buildResendCodeButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpResentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(state.message),
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
          setState(() {
            widget._isRequestInProgress = false;
            widget.hash = state.hash;
            _isResendEnabled = false;
            _remainingTime = 180; // reset timer to 3 minutes
          });
          _startTimer(); // restart the timer
          // AppNavigator.pushReplacement(context, SigninScreen());
        } else if (state is AuthOtpResentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(child: Text(state.message)),
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

          setState(() {
            widget._isRequestInProgress = false;
          });
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_formatRemainingTime(_remainingTime)}',
              style: TextStyle(color: Colors.red.shade400),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: (_isResendEnabled && !widget._isRequestInProgress)
                  ? () {
                      setState(() {
                        widget._isRequestInProgress = true;
                      });
                      context.read<AuthBloc>().add(
                            AuthResendVerificationCodeEvent(
                              email: widget.email,
                            ),
                          );

                      print("${state.runtimeType}");
                    }
                  : null,
              child: Text(
                'Resend Code',
                style: TextStyle(
                  color: _isResendEnabled ? Colors.red.shade400 : Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Sign-in link
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
