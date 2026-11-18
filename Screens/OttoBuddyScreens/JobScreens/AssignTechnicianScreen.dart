import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/WrapperScreens/OttoBuddyMainWrapper.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class AssignTechnicianScreen extends StatefulWidget {
  const AssignTechnicianScreen({super.key});

  @override
  State<AssignTechnicianScreen> createState() => _AssignTechnicianScreenState();
}

class _AssignTechnicianScreenState extends State<AssignTechnicianScreen> {
  String _selectedGarage = 'Select';
  String _selectedTechnician = '--';
  String _selectedPhone = '--';
  String _selectedRatings = '--';

  final List<String> _garageOptions = ['Select', 'Garage A', 'Garage B', 'Garage C', 'Garage D'];
  final List<String> _technicianOptions = ['--', 'Suraj Kumar', 'Rahul Sharma', 'Amit Singh', 'Vikram Patel'];
  final List<String> _phoneOptions = ['--', '+91 9876543210', '+91 9876543211', '+91 9876543212', '+91 9876543213'];
  final List<String> _ratingsOptions = ['--', '⭐⭐⭐⭐⭐', '⭐⭐⭐⭐', '⭐⭐⭐', '⭐⭐'];

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
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          size: width * 0.06,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: width * 0.055,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.025),

                  // Garage Field
                  _buildDropdownField(
                    label: 'Garage',
                    value: _selectedGarage,
                    options: _garageOptions,
                    isDarkMode: isDarkMode,
                    width: width,
                    height: height,
                    onChanged: (value) {
                      setState(() {
                        _selectedGarage = value;
                      });
                    },
                  ),

                  SizedBox(height: height * 0.015),

                  // Technician Name Field (Non-editable)
                  _buildTextField(
                    label: 'Technician Name',
                    value: 'Suraj Kumar',
                    isDarkMode: isDarkMode,
                    width: width,
                    height: height,
                    isEditable: false,
                  ),

                  SizedBox(height: height * 0.02),

                  // Technician Section Title
                  Text(
                    'Technician',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  // Technician Details Card
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRowWithDropdown(
                          label: 'Technician Name',
                          value: _selectedTechnician,
                          options: _technicianOptions,
                          isDarkMode: isDarkMode,
                          width: width,
                          height: height,
                          onChanged: (value) {
                            setState(() {
                              _selectedTechnician = value;
                            });
                          },
                        ),
                        _buildDetailRowWithDropdown(
                          label: 'Phone Number',
                          value: _selectedPhone,
                          options: _phoneOptions,
                          isDarkMode: isDarkMode,
                          width: width,
                          height: height,
                          onChanged: (value) {
                            setState(() {
                              _selectedPhone = value;
                            });
                          },
                        ),
                        _buildDetailRowWithDropdown(
                          label: 'Ratings',
                          value: _selectedRatings,
                          options: _ratingsOptions,
                          isDarkMode: isDarkMode,
                          width: width,
                          height: height,
                          onChanged: (value) {
                            setState(() {
                              _selectedRatings = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  // Done Button
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate and assign technician
                        if (_selectedGarage == 'Select' ||
                            _selectedTechnician == '--' ||
                            _selectedPhone == '--' ||
                            _selectedRatings == '--') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select all fields'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }

                        // Show success and navigate to home
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Technician assigned successfully!'),
                            backgroundColor: AppColor.primary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        // Navigate to home screen
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OttoBuddyMainWrapper(initialIndex: 0),
                            ),
                                (route) => false,
                          );
                        });
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

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> options,
    required bool isDarkMode,
    required double width,
    required double height,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.035,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
          ),
        ),
        SizedBox(height: height * 0.005),
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                size: width * 0.05,
              ),
              items: options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required bool isDarkMode,
    required double width,
    required double height,
    bool isEditable = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.035,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
          ),
        ),
        SizedBox(height: height * 0.005),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.016,
          ),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                  ),
                ),
              ),
              if (isEditable)
                Icon(
                  Icons.edit_rounded,
                  color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                  size: width * 0.04,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithDropdown({
    required String label,
    required String value,
    required List<String> options,
    required bool isDarkMode,
    required double width,
    required double height,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.006),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white.withOpacity(0.04) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  dropdownColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                  style: TextStyle(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                    size: width * 0.04,
                  ),
                  items: options.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}