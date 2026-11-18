import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/ProfileUnderReviewScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/ProfileStepHelpers.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class CompleteProfileStepFour extends StatefulWidget {
  const CompleteProfileStepFour({super.key});

  @override
  State<CompleteProfileStepFour> createState() => _CompleteProfileStepFourState();
}

class _CompleteProfileStepFourState extends State<CompleteProfileStepFour> {
  String _selectedRole = '';
  bool _isDeclarationChecked = false;
  int _selectedHourIndex = 1;

  static const int currentStep = 4;

  final List<String> _roles = [
    'Mechanic',
    'SOS Technician',
    'Car Washer',
    'Delivery Partner',
    'Insurance Agent',
  ];

  final List<String> _hourOptions = ['4 hrs', '8 hrs', '8 hrs'];

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

                  SizedBox(height: height * 0.025),

                  // Step Indicators
                  buildStepper(currentStep, isDarkMode, width),

                  SizedBox(height: height * 0.03),

                  // Select the role
                  Text(
                    'Select the role',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.012),

                  // Role Options (2-column grid)
                  Wrap(
                    spacing: width * 0.03,
                    runSpacing: height * 0.012,
                    children: _roles.map((role) {
                      final isSelected = _selectedRole == role;
                      final cardWidth = (width * 0.88 - width * 0.03) / 2;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedRole = role),
                        child: SizedBox(
                          width: cardWidth,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.016,
                                  horizontal: width * 0.035,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColor.primary.withOpacity(0.08)
                                      : (isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColor.primary
                                        : (isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade300),
                                    width: isSelected ? 1.5 : 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Are you',
                                      style: TextStyle(
                                        fontSize: width * 0.03,
                                        fontWeight: FontWeight.w400,
                                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.002),
                                    Text(
                                      role,
                                      style: TextStyle(
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Positioned(
                                  top: -6,
                                  right: -6,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check_circle_rounded,
                                      color: AppColor.primary,
                                      size: width * 0.05,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: height * 0.025),

                  // Earnings Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.05),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: width * 0.12,
                          height: width * 0.12,
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.currency_rupee_rounded,
                            color: Colors.white,
                            size: width * 0.06,
                          ),
                        ),
                        SizedBox(height: height * 0.012),
                        Text(
                          'You can earn upto',
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: height * 0.004),
                        Text(
                          '₹50,200',
                          style: TextStyle(
                            fontSize: width * 0.07,
                            fontWeight: FontWeight.w800,
                            color: AppColor.primary,
                          ),
                        ),
                        SizedBox(height: height * 0.004),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Per Month',
                              style: TextStyle(
                                fontSize: width * 0.032,
                                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(width: width * 0.015),
                            Icon(
                              Icons.info_outline_rounded,
                              size: width * 0.035,
                              color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.015),
                        Text(
                          'You work every dat for 6 hrs...',
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: height * 0.012),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_hourOptions.length, (index) {
                            return Padding(
                              padding: EdgeInsets.only(right: index != _hourOptions.length - 1 ? width * 0.02 : 0),
                              child: _buildTimeChip(_hourOptions[index], index, isDarkMode, width),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Declaration
                  Text(
                    'Declaration',
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDeclarationChecked = !_isDeclarationChecked;
                          });
                        },
                        child: Container(
                          width: width * 0.05,
                          height: width * 0.05,
                          margin: EdgeInsets.only(top: height * 0.003),
                          decoration: BoxDecoration(
                            color: _isDeclarationChecked ? AppColor.primary : Colors.transparent,
                            border: Border.all(
                              color: _isDeclarationChecked ? AppColor.primary : Colors.grey.shade400,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: _isDeclarationChecked
                              ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 16,
                          )
                              : null,
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Expanded(
                        child: Text(
                          'I hereby declare that the above information is true and I agree to follow FixOtto service standards and accept all the Terms & Conditions. I also declare that there is no criminal or civil case pending against me.',
                          style: TextStyle(
                            fontSize: width * 0.03,
                            color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.03),

                  // Done Button
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedRole.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a role'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        if (!_isDeclarationChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please accept the declaration'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileUnderReviewScreen(),
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
                        'Done',
                        style: TextStyle(
                          fontSize: 16,
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
      ),
    );
  }

  Widget _buildTimeChip(String label, int index, bool isDarkMode, double width) {
    // Track selection by index since "8 hrs" appears twice in the reference.
    final bool isSelected = _selectedHourIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedHourIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.045,
          vertical: width * 0.02,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : (isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColor.primary : (isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: width * 0.032,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : (isDarkMode ? AppColor.textPrimary : Colors.black87),
          ),
        ),
      ),
    );
  }
}