// TechnicianProfileScreen.dart
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/ProfileScreens/TechnicianEditProfileScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/ProfileScreens/TechnicianPrivacyPolicyScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/ProfileScreens/TechnicianReviewsScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/ProfileScreens/TechnicianTermsConditionScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../MainWrapper/TechnicianMainWrapper.dart';
import '../TechnicianAuth/LoginScreen/LoginScreen.dart';
import '../WalletScreen/TechnicianWalletScreen.dart';

class TechnicianProfileScreen extends StatefulWidget {
  const TechnicianProfileScreen({super.key});

  @override
  State<TechnicianProfileScreen> createState() => _TechnicianProfileScreenState();
}

class _TechnicianProfileScreenState extends State<TechnicianProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateStatusBar());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateStatusBar();
  }

  void _updateStatusBar() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    ));
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const TechnicianMainWrapper(initialIndex: 0),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _navigateToHome();
      },
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: isDarkMode ? AppColor.getOnboardingGradient(Theme.of(context).brightness) : null,
            color: isDarkMode ? null : Colors.white,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  width * 0.06,
                  height * 0.025,
                  width * 0.06,
                  height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Email
                    Text(
                      'Rohit sharma',
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? AppColor.textPrimary : const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: height * 0.006),
                    Text(
                      'rohitsharma12@gmail.com',
                      style: TextStyle(
                        fontSize: width * 0.037,
                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // Menu Items
                    _buildMenuItem(
                      Icons.person_outline_rounded,
                      'Personal Information',
                      'Incomplete',
                      isDarkMode,
                      width,
                      height,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TechnicianEditProfileScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      Icons.description_outlined,
                      'Terms & Condition',
                      null,
                      isDarkMode,
                      width,
                      height,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TechnicianTermsConditionScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      Icons.shield_outlined,
                      'Privacy Policy',
                      null,
                      isDarkMode,
                      width,
                      height,
                      showDivider: true,  // Show divider after Privacy Policy
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TechnicianPrivacyPolicyScreen()),
                      ),
                    ),

                    _buildMenuItem(
                      Icons.star_outline_rounded,
                      'Reviews',
                      null,
                      isDarkMode,
                      width,
                      height,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TechnicianReviewsScreen()),
                      ),
                    ),
                    _buildMenuItem(
                      Icons.account_balance_wallet_outlined,
                      'Wallet',
                      null,
                      isDarkMode,
                      width,
                      height,
                      showDivider: false,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TechnicianWalletScreen()),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // Help & Support Card
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to Help & Support
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: height * 0.028),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildHelpBubbleIcon(width),
                            SizedBox(height: height * 0.012),
                            Text(
                              'Help & support',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.022),

                    // Logout button
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.058,
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (route) => false,
                        ),
                        icon: const Icon(Icons.logout_rounded, color: Colors.red),
                        label: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.012),

                    // Version
                    Center(
                      child: Text(
                        'v3.1.1.0',
                        style: TextStyle(
                          fontSize: width * 0.032,
                          color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHelpBubbleIcon(double width) {
    final double size = width * 0.14;
    return SizedBox(
      width: size,
      height: size * 0.85,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.chat_bubble,
              size: size * 0.62,
              color: const Color(0xFFFF8A80),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.chat_bubble,
                  size: size * 0.7,
                  color: const Color(0xFF42A5F5),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size * 0.1),
                  child: Text(
                    '?',
                    style: TextStyle(
                      fontSize: size * 0.32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon,
      String title,
      String? subtitle,
      bool isDarkMode,
      double width,
      double height, {
        VoidCallback? onTap,
        bool showDivider = true,
      }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            child: Row(
              children: [
                Icon(icon, color: AppColor.primary, size: width * 0.055),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.02),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: width * 0.037,
                        color: AppColor.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Icon(Icons.chevron_right_rounded, size: width * 0.055, color: AppColor.primary),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.08),
            thickness: 0.6,
            height: 0,
          ),
      ],
    );
  }
}