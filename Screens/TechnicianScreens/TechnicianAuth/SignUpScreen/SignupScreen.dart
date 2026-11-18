import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/CompleteProfileStepOne.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false;
  bool _isLoading = false;
  int _timerSeconds = 299;
  bool _isTimerActive = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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

  void _signup() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String otp = _otpController.text.trim();

    if (name.isEmpty) {
      _showSnackBar('Enter your name');
      return;
    }
    if (email.isEmpty) {
      _showSnackBar('Enter your email');
      return;
    }
    if (!email.contains('@')) {
      _showSnackBar('Enter a valid email');
      return;
    }
    if (phone.isEmpty) {
      _showSnackBar('Enter your phone number');
      return;
    }
    if (phone.length < 10) {
      _showSnackBar('Enter a valid phone number');
      return;
    }
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
        _showSnackBar('Signup successful!');
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

    final double imageHeight = height * 0.28;
    final double overlapAmount = imageHeight * 0.065;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppColor.getOnboardingGradient(brightness)
              : const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFB3E5FC),
              Color(0xFFF5F5F5),
            ],
          ),
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
                      imageHeight * 0.065 + height * 0.015,
                      width * 0.06,
                      height * 0.03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Sign up to Your Account',
                          style: TextStyle(
                            fontSize: width * 0.065,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? AppColor.textPrimary
                                : const Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Enter your email and password to log in',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            color: isDarkMode
                                ? AppColor.textSecondary
                                : Colors.black45,
                          ),
                        ),
                        SizedBox(height: height * 0.02),

                        // Name Field
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? AppColor.textPrimary
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
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
                            controller: _nameController,
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppColor.textPrimary
                                  : Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Loisbecket@gmail.com',
                              hintStyle: TextStyle(
                                color: isDarkMode
                                    ? AppColor.textTertiary
                                    : Colors.black26,
                                fontSize: width * 0.035,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: height * 0.015,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.015),

                        // Email Field
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? AppColor.textPrimary
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppColor.textPrimary
                                  : Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Loisbecket@gmail.com',
                              hintStyle: TextStyle(
                                color: isDarkMode
                                    ? AppColor.textTertiary
                                    : Colors.black26,
                                fontSize: width * 0.035,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: height * 0.015,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.015),

                        // Phone Number Field
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
                        const SizedBox(height: 6),
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
                              // Phone icon
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.04),
                                child: Icon(
                                  Icons.phone_outlined,
                                  color: isDarkMode
                                      ? AppColor.textTertiary
                                      : Colors.black45,
                                  size: width * 0.045,
                                ),
                              ),
                              const SizedBox(width: 8),
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
                                    hintText: '+91 80721977329',
                                    hintStyle: TextStyle(
                                      color: isDarkMode
                                          ? AppColor.textTertiary
                                          : Colors.black26,
                                      fontSize: width * 0.035,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                      vertical: height * 0.015,
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

                        SizedBox(height: height * 0.015),

                        // OTP Field
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
                        const SizedBox(height: 6),
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
                                      vertical: height * 0.015,
                                    ),
                                  ),
                                ),
                              ),
                              if (_isTimerActive)
                                Padding(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        SizedBox(height: height * 0.008),

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

                        // Signup Button
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.065,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signup,
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
                              'Signup',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.015),

                        // Login Link
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account? ",
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
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Login',
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
    );
  }
}
