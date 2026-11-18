import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/JobScreens/AssignTechnicianScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class JobCardScreenThree extends StatelessWidget {
  final bool isCompleted;
  const JobCardScreenThree({super.key, this.isCompleted = false});

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
                        'Details',
                        style: TextStyle(
                          fontSize: width * 0.055,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Job Card Header
                  _buildJobCardHeader(isDarkMode, width),

                  SizedBox(height: height * 0.02),

                  // Customer Details card
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Name', 'Rahul Sharma', isDarkMode, width),
                        _buildDetailRow('Phone Number', '+91 8023993884', isDarkMode, width),
                        _buildStatusRow('Status', 'Completed', isDarkMode, width, height),

                        _buildDivider(isDarkMode, width),

                        _buildSectionTitle('Vehicle Info', isDarkMode, width),
                        _buildDetailRow('Vehicle Number', 'DI XX D5 1200', isDarkMode, width),
                        _buildDetailRow('Vehicle Type', 'Lorem Ipsum', isDarkMode, width),
                        _buildDetailRow('Model Number', 'Lorem Ipsum', isDarkMode, width),

                        _buildDivider(isDarkMode, width),

                        _buildSectionTitle('Service Info', isDarkMode, width),
                        _buildDetailRow('Service Name', 'Lorem Ipsum', isDarkMode, width),
                        _buildDetailRow('Package', 'Lorem Ipsum', isDarkMode, width),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Inspection
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Inspection', isDarkMode, width),
                        SizedBox(height: height * 0.005),
                        Text(
                          'Inspection Video',
                          style: TextStyle(
                            fontSize: width * 0.034,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFieldBox('Video.Mp4', isDarkMode, width, height),
                            ),
                            SizedBox(width: width * 0.03),
                            _buildViewButton(width, height),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Enter Details
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Enter Details', isDarkMode, width),
                        SizedBox(height: height * 0.005),
                        _buildLabelValue('Estimated Time To Arrange The Parts', '20 mints', isDarkMode, width, height),
                        _buildLabelValue('Estimated Time To Arrange The Work', '20 mints', isDarkMode, width, height),
                        _buildLabelValue('Additional Parts Cost', '₹1200', isDarkMode, width, height),
                        _buildLabelValue('Labor Charges', '₹450', isDarkMode, width, height),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Job Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Job Card', isDarkMode, width),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFieldBox('Job Card', isDarkMode, width, height),
                            ),
                            SizedBox(width: width * 0.03),
                            _buildViewButton(width, height),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Assign Technician
                  if (!isCompleted)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Assign Technician', isDarkMode, width),
                        SizedBox(height: height * 0.008),
                        _buildDetailRow('Garage Name', '--', isDarkMode, width),
                        _buildDetailRow('Technician Name', '--', isDarkMode, width),
                        _buildDetailRow('Phone Number', '--', isDarkMode, width),
                        _buildDetailRow('Ratings', '--', isDarkMode, width),
                        SizedBox(height: height * 0.015),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.055,
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AssignTechnicianScreen()),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3CB878),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Assign Technician',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isCompleted)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Technician Details', isDarkMode, width),
                        SizedBox(height: height * 0.008),
                        _buildDetailRow('Garage Name', 'Fixotto Garage', isDarkMode, width),
                        _buildDetailRow('Technician Name', 'Amit Verma', isDarkMode, width),
                        _buildDetailRow('Phone Number', '+91 9876543210', isDarkMode, width),
                        _buildDetailRow('Ratings', '4.5 ⭐', isDarkMode, width),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.025),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---- Header with centered "Job Card" title + logo row ----
  Widget _buildJobCardHeader(bool isDarkMode, double width) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Job Card',
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
            ),
          ),
          SizedBox(height: width * 0.03),
          Row(
            children: [
              Container(
                width: width * 0.14,
                height: width * 0.14,
               
                child:  Image.asset(
                  ImageAssets.statsImage,
                  width: width * 0.2,
                  height: width * 0.2,
                  fit: BoxFit.contain,

                ),
              ),
              SizedBox(width: width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fixotto',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  Text(
                    'AUTOMOTIVE',
                    style: TextStyle(
                      fontSize: width * 0.026,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDarkMode, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.03),
      child: Divider(
        height: 1,
        thickness: 1,
        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode, double width) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.02),
      child: Text(
        title,
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.32,
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
            child: Text(
              value,
              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Stacked label above value (matches "Enter Details" section in the reference)
  Widget _buildLabelValue(String label, String value, bool isDarkMode, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.008),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.033,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
            ),
          ),
          SizedBox(height: height * 0.004),
          Text(
            value,
            style: TextStyle(
              fontSize: width * 0.033,
              fontWeight: FontWeight.w400,
              color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, bool isDarkMode, double width, double height) {
    final bool isNew = value == 'New';
    final Color statusColor = isNew ? const Color(0xFF1E88E5) : const Color(0xFF2FAE60);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.32,
            child: Text(
              label,
              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.005,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bordered "input-style" box used for Video.Mp4 / Job Card fields
  Widget _buildFieldBox(String text, bool isDarkMode, double width, double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.014,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.04) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode ? Colors.white.withOpacity(0.12) : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: width * 0.033,
          fontWeight: FontWeight.w400,
          color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade500,
        ),
      ),
    );
  }

  // Pale teal "View" pill button used beside field boxes
  Widget _buildViewButton(double width, double height) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.014,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFD3ECEA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'View',
        style: TextStyle(
          fontSize: width * 0.032,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2C6E68),
        ),
      ),
    );
  }
}