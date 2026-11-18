import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/CompleteProfileStepFour.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/ProfileStepHelpers.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class CompleteProfileStepThree extends StatefulWidget {
  const CompleteProfileStepThree({super.key});

  @override
  State<CompleteProfileStepThree> createState() => _CompleteProfileStepThreeState();
}

class _CompleteProfileStepThreeState extends State<CompleteProfileStepThree> {
  String _workTimingFrom = '--';
  String _workTimingTo = '--';
  String _paymentMode = '';
  final TextEditingController _drivingLicenseController = TextEditingController();

  static const int currentStep = 3;

  final List<String> _timeOptions = [
    '--',
    '6:00 AM', '7:00 AM', '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM',
    '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM',
    '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM',
  ];

  Future<void> _pickTime(bool isFrom) async {
    final String? current = isFrom ? _workTimingFrom : _workTimingTo;
    final String? selected = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: _timeOptions.map((time) {
              return ListTile(
                title: Text(time),
                selected: time == current,
                onTap: () => Navigator.pop(context, time),
              );
            }).toList(),
          ),
        );
      },
    );
    if (selected != null) {
      setState(() {
        if (isFrom) {
          _workTimingFrom = selected;
        } else {
          _workTimingTo = selected;
        }
      });
    }
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

                  // Work Timing
                  Text(
                    'Work Timing',
                    style: TextStyle(
                      fontSize: width * 0.038,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.014),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: width * 0.045, color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400),
                        SizedBox(width: width * 0.02),
                        GestureDetector(
                          onTap: () => _pickTime(true),
                          child: Text(
                            _workTimingFrom == '--' ? 'from' : _workTimingFrom,
                            style: TextStyle(
                              fontSize: width * 0.033,
                              color: _workTimingFrom == '--'
                                  ? (isDarkMode ? AppColor.textTertiary : Colors.grey.shade400)
                                  : (isDarkMode ? AppColor.textPrimary : Colors.black87),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '--',
                          style: TextStyle(
                            fontSize: width * 0.033,
                            color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _pickTime(false),
                          child: Text(
                            _workTimingTo == '--' ? 'to' : _workTimingTo,
                            style: TextStyle(
                              fontSize: width * 0.033,
                              color: _workTimingTo == '--'
                                  ? (isDarkMode ? AppColor.textTertiary : Colors.grey.shade400)
                                  : (isDarkMode ? AppColor.textPrimary : Colors.black87),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Icon(Icons.access_time_rounded, size: width * 0.045, color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Payment Mode
                  Text(
                    'Payment Mode',
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
                        'Bank',
                        _paymentMode == 'Bank',
                        isDarkMode,
                        width,
                            () => setState(() => _paymentMode = 'Bank'),
                      ),
                      SizedBox(width: width * 0.06),
                      buildCheckboxOption(
                        'UPI',
                        _paymentMode == 'UPI',
                        isDarkMode,
                        width,
                            () => setState(() => _paymentMode = 'UPI'),
                      ),
                      SizedBox(width: width * 0.06),
                      buildCheckboxOption(
                        'Cash',
                        _paymentMode == 'Cash',
                        isDarkMode,
                        width,
                            () => setState(() => _paymentMode = 'Cash'),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Driving Licence No
                  buildPillTextField(
                    'Driving Licence No',
                    'Enter',
                    _drivingLicenseController,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.02),

                  // RC Photo Upload
                  buildUploadBox('RC photo', isDarkMode, width, height, () {
                    // Upload document
                  }),

                  SizedBox(height: height * 0.018),

                  // License Photo Upload
                  buildUploadBox('License photo', isDarkMode, width, height, () {
                    // Upload document
                  }),

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
                            builder: (context) => const CompleteProfileStepFour(),
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

                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}