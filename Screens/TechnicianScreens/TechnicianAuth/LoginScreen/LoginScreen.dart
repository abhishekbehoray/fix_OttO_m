import 'package:fixottobuddy_techni/Screens/CommonScreens/Auth/OnboardingScreens/RoleSelectionScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/CompleteProfileStepOne.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

import '../SignUpScreen/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false;
  bool _isLoading = false;
  int _timerSeconds = 299;
  bool _isTimerActive = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _timerSeconds = 299;
      _isTimerActive = true;
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          if (_timerSeconds > 0) {
            _timerSeconds--;
          } else {
            _isTimerActive = false;
          }
        });
      }
      return _timerSeconds > 0 && mounted;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _sendOtp() {
    String phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      _showSnackBar('Enter your phone number');
      return;
    }
    if (phone.length < 10) {
      _showSnackBar('Enter a valid phone number');
      return;
    }
    setState(() {
      _isOtpSent = true;
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _startTimer();
        _showSnackBar('OTP sent successfully!');
      }
    });
  }

  void _login() {
    String otp = _otpController.text.trim();
    if (otp.isEmpty) {
      _showSnackBar('Enter OTP');
      return;
    }
    if (otp.length < 4) {
      _showSnackBar('Enter a valid OTP');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Login successful!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CompleteProfileStepOne()),
        );
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColor.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    // Smaller image height (reduced from 0.38 to 0.32)
    final double imageHeight = height * 0.32;
    final double overlapAmount = imageHeight * 0.065;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
        );
      },
      child: Scaffold(
        body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppColor.getOnboardingGradient(brightness)
              : null,
          color: isDarkMode ? null : Colors.white,
        ),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Stack(
            children: [
              // Card background positioned below image
              Positioned(
                top: imageHeight - overlapAmount,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF2A2A4A) : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              // Image on top, overlapping the card
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  ImageAssets.logSignImage,
                  height: imageHeight + overlapAmount,
                  fit: BoxFit.contain,
                ),
              ),
              // Card content
              Positioned(
                top: imageHeight - overlapAmount,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      width * 0.06,
                      imageHeight * 0.065 + height * 0.02,
                      width * 0.06,
                      height * 0.03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Login to Your Account',
                          style: TextStyle(
                            fontSize: width * 0.065,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? AppColor.textPrimary
                                : const Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Enter your phone number to receive OTP',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            color: isDarkMode
                                ? AppColor.textSecondary
                                : Colors.black45,
                          ),
                        ),
                        SizedBox(height: height * 0.025),

                        // Phone Number Label
                        Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? AppColor.textPrimary
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Phone Input Row
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.15)
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColor.textPrimary
                                        : Colors.black87,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter phone number',
                                    hintStyle: TextStyle(
                                      color: isDarkMode
                                          ? AppColor.textTertiary
                                          : Colors.black26,
                                      fontSize: width * 0.035,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                      vertical: height * 0.018,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: _isOtpSent ? null : _sendOtp,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: _isLoading && !_isOtpSent
                                      ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColor.primary,
                                    ),
                                  )
                                      : Text(
                                    _isOtpSent ? 'Resend' : 'Get OTP',
                                    style: TextStyle(
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w600,
                                      color: _isOtpSent
                                          ? (isDarkMode ? AppColor.textTertiary : Colors.grey)
                                          : AppColor.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: height * 0.02),

                        // OTP Label
                        Text(
                          'OTP',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? AppColor.textPrimary
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // OTP Input
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.15)
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppColor.textPrimary
                                  : Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter OTP',
                              hintStyle: TextStyle(
                                color: isDarkMode
                                    ? AppColor.textTertiary
                                    : Colors.black26,
                                fontSize: width * 0.035,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: height * 0.018,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.01),

                        // Timer
                        if (_isTimerActive)
                          Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Valid in ',
                                    style: TextStyle(
                                      fontSize: width * 0.035,
                                      color: isDarkMode
                                          ? AppColor.textSecondary
                                          : Colors.black45,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _formatTime(_timerSeconds),
                                    style: TextStyle(
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w600,
                                      color: _timerSeconds < 60
                                          ? Colors.red
                                          : AppColor.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        SizedBox(height: height * 0.025),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.065,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                                : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.02),

                        // Signup Link with Navigation
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account  ",
                                  style: TextStyle(
                                    fontSize: width * 0.035,
                                    color: isDarkMode
                                        ? AppColor.textSecondary
                                        : Colors.black45,
                                  ),
                                ),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const  SignupScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Signup',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.02),
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
    );
  }
}
