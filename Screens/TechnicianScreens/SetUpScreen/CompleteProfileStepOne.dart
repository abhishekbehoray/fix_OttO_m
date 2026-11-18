import 'package:fixottobuddy_techni/Screens/TechnicianScreens/SetUpScreen/CompleteProfileStepTwo.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class CompleteProfileStepOne extends StatefulWidget {
  const CompleteProfileStepOne({super.key});

  @override
  State<CompleteProfileStepOne> createState() => _CompleteProfileStepOneState();
}

class _CompleteProfileStepOneState extends State<CompleteProfileStepOne> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  String _maritalStatus = '';
  String _profileImage = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _aadhaarController.dispose();
    super.dispose();
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ListTile(
              leading: Icon(
                Icons.photo_camera_rounded,
                color: AppColor.primary,
                size: MediaQuery.of(context).size.width * 0.055,
              ),
              title: Text(
                'Take Photo',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle camera
                setState(() {
                  _profileImage = 'camera';
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library_rounded,
                color: AppColor.primary,
                size: MediaQuery.of(context).size.width * 0.055,
              ),
              title: Text(
                'Choose from Gallery',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle gallery
                setState(() {
                  _profileImage = 'gallery';
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: MediaQuery.of(context).size.width * 0.055,
              ),
              title: Text(
                'Remove Photo',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _profileImage = '';
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
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
                  Text(
                    'Complete your profile',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Step Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStepIndicator(1, '01', 'Step 01', true, isDarkMode, width),
                      _buildStepIndicator(2, '02', 'Step 02', false, isDarkMode, width),
                      _buildStepIndicator(3, '03', 'Step 03', false, isDarkMode, width),
                      _buildStepIndicator(4, '04', 'Step 04', false, isDarkMode, width),
                    ],
                  ),

                  SizedBox(height: height * 0.025),

                  // Profile Picture
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: width * 0.2,
                          height: width * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                            border: Border.all(
                              color: AppColor.primary,
                              width: 2,
                            ),
                            image: _profileImage.isNotEmpty
                                ? DecorationImage(
                              image: AssetImage(_profileImage),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: _profileImage.isEmpty
                              ? Icon(
                            Icons.person_rounded,
                            size: width * 0.1,
                            color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                          )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _showImagePicker,
                            child: Container(
                              padding: EdgeInsets.all(width * 0.015),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDarkMode ? Colors.black : Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Full Name
                  _buildTextField(
                    'Full Name',
                    'Enter name',
                    _fullNameController,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.015),

                  // Email
                  _buildTextField(
                    'Email',
                    'Enter email',
                    _emailController,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.015),

                  // Phone Number
                  _buildTextField(
                    'Phone Number',
                    'Enter',
                    _phoneController,
                    isDarkMode,
                    width,
                    height,
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: height * 0.015),

                  // Date of Birth
                  _buildTextField(
                    'Date of Birth',
                    'Enter DOB',
                    _dobController,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.015),

                  // Aadhaar No
                  _buildTextField(
                    'Aadhaar No',
                    'Enter',
                    _aadhaarController,
                    isDarkMode,
                    width,
                    height,
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: height * 0.015),

                  // Marital Status
                  Text(
                    'Marital Status',
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: height * 0.008),
                  Row(
                    children: [
                      _buildRadioOption('Single', _maritalStatus, isDarkMode, width),
                      SizedBox(width: width * 0.05),
                      _buildRadioOption('Married', _maritalStatus, isDarkMode, width),
                    ],
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
                            builder: (context) => const CompleteProfileStepTwo(),
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

  Widget _buildStepIndicator(
      int step,
      String number,
      String label,
      bool isActive,
      bool isDarkMode,
      double width,
      ) {
    return Column(
      children: [
        Container(
          width: width * 0.1,
          height: width * 0.1,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColor.primary : (isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade200),
            border: Border.all(
              color: isActive ? AppColor.primary : (isDarkMode ? Colors.white.withOpacity(0.15) : Colors.grey.shade300),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w700,
                color: isActive ? Colors.white : (isDarkMode ? AppColor.textTertiary : Colors.grey.shade500),
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.022,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive
                ? AppColor.primary
                : (isDarkMode ? AppColor.textTertiary : Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label,
      String hint,
      TextEditingController controller,
      bool isDarkMode,
      double width,
      double height, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.032,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
          ),
        ),
        SizedBox(height: height * 0.004),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
              fontSize: width * 0.032,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                fontSize: width * 0.032,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.035,
                vertical: height * 0.012,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String label, String selectedValue, bool isDarkMode, double width) {
    final bool isSelected = selectedValue == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _maritalStatus = label;
        });
      },
      child: Row(
        children: [
          Container(
            width: width * 0.04,
            height: width * 0.04,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColor.primary : (isDarkMode ? AppColor.textTertiary : Colors.grey.shade400),
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: width * 0.018,
                height: width * 0.018,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary,
                ),
              ),
            )
                : null,
          ),
          SizedBox(width: width * 0.02),
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.032,
              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}