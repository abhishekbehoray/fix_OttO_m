import 'package:fixottobuddy_techni/Screens/CommonScreens/Auth/OnboardingScreens/RoleSelectionScreen.dart';
import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/WrapperScreens/OttoBuddyMainWrapper.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class OttoBuddyLoginScreen extends StatefulWidget {
  const OttoBuddyLoginScreen({super.key});

  @override
  State<OttoBuddyLoginScreen> createState() => _OttoBuddyLoginScreenState();
}

class _OttoBuddyLoginScreenState extends State<OttoBuddyLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();

    if (phone.isEmpty) {
      _showSnackBar('Enter your phone number');
      return;
    }
    if (phone.length < 10) {
      _showSnackBar('Enter a valid phone number');
      return;
    }
    if (password.isEmpty) {
      _showSnackBar('Enter your password');
      return;
    }
    if (password.length < 6) {
      _showSnackBar('Password must be at least 6 characters');
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
        // Navigate to home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OttoBuddyMainWrapper(),
          ),
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
                          'Enter your phone number and password to log in',
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

                        // Phone Number Input with Country Code
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '+91',
                                      style: TextStyle(
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode
                                            ? AppColor.textPrimary
                                            : Colors.black87,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: isDarkMode
                                          ? AppColor.textTertiary
                                          : Colors.grey.shade400,
                                      size: width * 0.04,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: height * 0.025,
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.15)
                                    : Colors.grey.shade300,
                              ),
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
                                      horizontal: width * 0.03,
                                      vertical: height * 0.018,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: height * 0.02),

                        // Password Label
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? AppColor.textPrimary
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Password Input
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
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColor.textPrimary
                                        : Colors.black87,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
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
                                onTap: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: isDarkMode
                                        ? AppColor.textTertiary
                                        : Colors.grey.shade400,
                                    size: width * 0.05,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.01),
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to forgot password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primary,
                                ),
                              ),
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