import 'package:fixottobuddy_techni/Screens/CommonScreens/Auth/OnboardingScreens/OnboardingScreenThree.dart';
import 'package:fixottobuddy_techni/Screens/CommonScreens/Auth/OnboardingScreens/RoleSelectionScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class OnboardingScreenMiddle extends StatelessWidget {
  const OnboardingScreenMiddle({super.key});

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
                // Top Section: Skip Button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsiveWidth * 0.045,
                          vertical: size.height * 0.012,
                        ),
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
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: AppColor.getTextSecondary(brightness),
                            fontSize: responsiveWidth * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
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
                          ImageAssets.onboardingScreenTwoImage,
                          width: responsiveWidth * 0.8,
                          height: responsiveWidth * 0.8,
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // Box with everything: Title, Subtitle, Pagination, Arrow
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
                              'Expert Mechanics,\nJust a Tap Away',
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
                              'Find skilled and verified mechanics near you for all types of vehicle services. Book trusted professionals quickly and hassle-free.',
                              style: TextStyle(
                                color: AppColor.getTextSecondary(brightness),
                                fontSize: responsiveWidth * 0.035,
                                fontWeight: FontWeight.w400,
                                height: 1.6,
                                letterSpacing: 0.2,
                              ),
                            ),

                            SizedBox(height: size.height * 0.025),

                            // Bottom Section: Pagination Lines + Green Arrow
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Pagination Lines (Middle page active - index 1 is green)
                                Row(
                                  children: List.generate(
                                    3,
                                        (index) => Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      width: index == 1
                                          ? responsiveWidth * 0.12
                                          : responsiveWidth * 0.06,
                                      height: responsiveWidth * 0.008,
                                      decoration: BoxDecoration(
                                        color: index == 1
                                            ? AppColor.primary
                                            : isDarkMode
                                            ? Colors.white.withOpacity(0.2)
                                            : Colors.black.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),

                                // Green Arrow Button - Navigates to Screen Three
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const OnboardingScreenThree(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(responsiveWidth * 0.04),
                                    decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.primary.withOpacity(0.3),
                                          blurRadius: 20,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: responsiveWidth * 0.06,
                                    ),
                                  ),
                                ),
                              ],
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