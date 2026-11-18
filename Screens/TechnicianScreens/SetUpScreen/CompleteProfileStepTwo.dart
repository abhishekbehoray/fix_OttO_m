import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/CompleteProfileStepThree.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/ProfileStepHelpers.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class CompleteProfileStepTwo extends StatefulWidget {
  const CompleteProfileStepTwo({super.key});

  @override
  State<CompleteProfileStepTwo> createState() => _CompleteProfileStepTwoState();
}

class _CompleteProfileStepTwoState extends State<CompleteProfileStepTwo> {
  String _education = '';
  String _experience = '';
  String _ownTools = '';
  String _smartphone = '';
  String _vehicleType = 'Car';

  final TextEditingController _specialisationController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController _preferredAreaController = TextEditingController();

  static const int currentStep = 2;

  final List<String> _vehicleOptions = ['Car', 'Bike', 'Scooter', 'Van'];

  @override
  void dispose() {
    _specialisationController.dispose();
    _vehicleNoController.dispose();
    _preferredAreaController.dispose();
    super.dispose();
  }

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
          gradient: isDarkMode ? AppColor.getOnboardingGradient(brightness) : null,
          color: isDarkMode ? null : Colors.white,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: height * 0.02),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(width * 0.02),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            size: width * 0.05,
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Text(
                        'Complete your profile',
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Step Indicators
                  buildStepper(currentStep, isDarkMode, width),

                  SizedBox(height: height * 0.03),

                  // Education
                  Text(
                    'Education',
                    style: TextStyle(
                      fontSize: width * 0.038,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Wrap(
                    spacing: width * 0.06,
                    runSpacing: height * 0.012,
                    children: ['Under 10th', '10th Pass', '12th Pass', 'Graduated', 'Other'].map((option) {
                      return SizedBox(
                        width: width * 0.27,
                        child: buildCheckboxOption(
                          option,
                          _education == option,
                          isDarkMode,
                          width,
                              () => setState(() => _education = option),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: height * 0.02),

                  // Experience
                  Text(
                    'Experience',
                    style: TextStyle(
                      fontSize: width * 0.038,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Wrap(
                    spacing: width * 0.06,
                    runSpacing: height * 0.012,
                    children: ['Fresher', '1-3 Years', '3-5 Years', '5+ Years'].map((option) {
                      return SizedBox(
                        width: width * 0.27,
                        child: buildCheckboxOption(
                          option,
                          _experience == option,
                          isDarkMode,
                          width,
                              () => setState(() => _experience = option),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: height * 0.02),

                  // Specialisation
                  buildPillTextField(
                    'Specialisation',
                    'Enter',
                    _specialisationController,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.02),

                  // Own Tools
                  Text(
                    'Own Tools',
                    style: TextStyle(
                      fontSize: width * 0.038,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      buildCheckboxOption(
                        'Yes',
                        _ownTools == 'Yes',
                        isDarkMode,
                        width,
                            () => setState(() => _ownTools = 'Yes'),
                      ),
                      SizedBox(width: width * 0.08),
                      buildCheckboxOption(
                        'No',
                        _ownTools == 'No',
                        isDarkMode,
                        width,
                            () => setState(() => _ownTools = 'No'),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Smartphone
                  Text(
                    'Smartphone',
                    style: TextStyle(
                      fontSize: width * 0.038,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      buildCheckboxOption(
                        'Yes',
                        _smartphone == 'Yes',
                        isDarkMode,
                        width,
                            () => setState(() => _smartphone = 'Yes'),
                      ),
                      SizedBox(width: width * 0.08),
                      buildCheckboxOption(
                        'No',
                        _smartphone == 'No',
                        isDarkMode,
                        width,
                            () => setState(() => _smartphone = 'No'),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Vehicle Type
                  buildPillDropdown(
                    'Vehicle Type*',
                    _vehicleType,
                    _vehicleOptions,
                    isDarkMode,
                    width,
                    height,
                        (value) => setState(() => _vehicleType = value!),
                  ),

                  SizedBox(height: height * 0.018),

                  // Vehicle No
                  buildPillTextField(
                    'Vehicle No',
                    'Enter',
                    _vehicleNoController,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.018),

                  // Preferred Area
                  buildPillTextField(
                    'Preferred Area',
                    'Enter',
                    _preferredAreaController,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.03),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompleteProfileStepThree(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.01),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}