import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

import 'OnboardingScreenTwo.dart';


class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({super.key});

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  @override
  void initState() {
    super.initState();
    // Navigate to OnboardingScreenTwo after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreenTwo(),
          ),
        );
      }
    });
  }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Image
              Image.asset(
                ImageAssets.splashLogo,
                width: responsiveWidth * 0.75,
                height: responsiveWidth * 0.75,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}