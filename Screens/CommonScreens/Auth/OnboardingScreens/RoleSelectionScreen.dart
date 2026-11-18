import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/OttoBuddyAuth/LoginScreen/OttoBuddyLoginScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/TechnicianAuth/LoginScreen/LoginScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: AppColor.getOnboardingGradient(brightness),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title - Centered
                Text(
                  "Let's Get You Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.065,
                    fontWeight: FontWeight.w700,
                    color: AppColor.getTextPrimary(brightness),
                  ),
                ),

                SizedBox(height: height * 0.012),

                // Subtitle - Centered
                Text(
                  'Choose your role to get started and unlock all features just for you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.037,
                    color: AppColor.getTextSecondary(brightness),
                    height: 1.4,
                  ),
                ),

                SizedBox(height: height * 0.03),

                // Illustration - Centered
                Image.asset(
                  ImageAssets.roleImageBanner,
                  width: width * 0.7,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: height * 0.04),

                // Technician Role Button
                _buildRoleButton(
                  context,
                  label: "I'm a Technician",
                  icon: Icons.person_rounded,
                  width: width,
                  height: height,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),

                SizedBox(height: height * 0.016),

                // Otto Buddy Role Button
                _buildRoleButton(
                  context,
                  label: "I'm a Otto Buddy",
                  icon: Icons.people_alt_rounded,
                  width: width,
                  height: height,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OttoBuddyLoginScreen(),
                      ),
                    );
                  },
                ),

                SizedBox(height: height * 0.025),

                // Skip Button - Centered
                // GestureDetector(
                //   onTap: () {
                //     // Skip and navigate to home
                //   },
                //   // child: Text(
                //   //   'Skip for now',
                //   //   style: TextStyle(
                //   //     fontSize: width * 0.035,
                //   //     fontWeight: FontWeight.w500,
                //   //     color: isDarkMode
                //   //         ? AppColor.textTertiary
                //   //         : Colors.grey.shade500,
                //   //   ),
                //   // ),
                // ),

                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(
      BuildContext context, {
        required String label,
        required IconData icon,
        required double width,
        required double height,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColor.primary.withOpacity(0.3),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: width * 0.05,
            ),
            SizedBox(width: width * 0.025),
            Text(
              label,
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}