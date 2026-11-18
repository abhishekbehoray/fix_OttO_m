import 'package:fixottobuddy_techni/Screens/CommonScreens/Auth/OnboardingScreens/RoleSelectionScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double responsiveWidth = size.width * 0.85;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: AppColor.getOnboardingGradient(brightness),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth * 0.05,
            ),
            child: Column(
              children: [
                // Top Section: Back Button (Arrow only)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate back to OnboardingScreenTwo with animation
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(responsiveWidth * 0.03),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.08)
                              : Colors.black.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.12)
                                : Colors.black.withOpacity(0.08),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColor.getTextSecondary(brightness),
                          size: responsiveWidth * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),

                // Middle Section: Content
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bigger Image/Illustration on top
                      Container(
                        width: responsiveWidth * 0.9,
                        height: responsiveWidth * 0.9,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: isDarkMode
                              ? const RadialGradient(
                            center: Alignment.center,
                            radius: 0.5,
                            colors: [
                              Color(0xFF2A2A5A),
                              Colors.transparent,
                            ],
                          )
                              : RadialGradient(
                            center: Alignment.center,
                            radius: 0.5,
                            colors: [
                              AppColor.gold.withOpacity(0.15),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Image.asset(
                          ImageAssets.onboardingScreenThreeImage,
                          width: responsiveWidth * 0.8,
                          height: responsiveWidth * 0.8,
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // Box with Title, Subtitle, and Get Started Button
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(responsiveWidth * 0.06),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.06)
                              : Colors.black.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.08)
                                : Colors.black.withOpacity(0.06),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title - Left Aligned
                            Text(
                              'Track Your Service\nin Real Time',
                              style: TextStyle(
                                color: AppColor.getTextPrimary(brightness),
                                fontSize: responsiveWidth * 0.075,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                                letterSpacing: 0.3,
                              ),
                            ),

                            SizedBox(height: size.height * 0.015),

                            // Subtitle - Left Aligned
                            Text(
                              'Follow each step of the service with live updates and images, and pay securely once the job is completed.',
                              style: TextStyle(
                                color: AppColor.getTextSecondary(brightness),
                                fontSize: responsiveWidth * 0.035,
                                fontWeight: FontWeight.w400,
                                height: 1.6,
                                letterSpacing: 0.2,
                              ),
                            ),

                            SizedBox(height: size.height * 0.025),

                            // Get Started Button - Navigates to Login Screen
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RoleSelectionScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.primary.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Get started',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: responsiveWidth * 0.045,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: responsiveWidth * 0.05,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
