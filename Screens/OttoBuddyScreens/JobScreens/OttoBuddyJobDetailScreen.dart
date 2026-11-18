import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/JobScreens/JobCardScreenOne.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class OttoBuddyJobDetailScreen extends StatelessWidget {
  const OttoBuddyJobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final Color cardColor = isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade50;
    final Color cardBorder = isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200;

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
                          padding: EdgeInsets.all(width * 0.025),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.08)
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            size: width * 0.05,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.1),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Banner Image with overlaid features (placeholder image)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        // TODO: Replace with actual job/vehicle image (Image.asset / Image.network)
                        Container(
                          width: double.infinity,
                          height: height * 0.22,
                          color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image_outlined,
                            size: width * 0.14,
                            color: isDarkMode ? Colors.white38 : Colors.grey.shade500,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                              width * 0.04,
                              height * 0.03,
                              width * 0.04,
                              height * 0.015,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.65),
                                ],
                              ),
                            ),
                            child: Wrap(
                              spacing: width * 0.08,
                              runSpacing: height * 0.006,
                              children: [
                                _buildFeatureBullet('Boosts Engine Performance', width),
                                _buildFeatureBullet('15% Milage Increase', width),
                                _buildFeatureBullet('Improves Vehicle Life', width),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.018),

                  // Booking ID
                  Text(
                    'Booking ID - BK1023',
                    style: TextStyle(
                      fontSize: width * 0.037,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700,
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Customer Details header + status badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Customer Details',
                        style: TextStyle(
                          fontSize: width * 0.043,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'New',
                          style: TextStyle(
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E88E5),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.01),

                  // Combined card: Customer Details + Schedule + Address
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cardBorder, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Name', 'Rahul Sharma', isDarkMode, width),
                        _buildDetailRow('Phone Number', '+91 8023993884', isDarkMode, width),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.014),
                          child: Divider(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                            thickness: 1,
                            height: 0,
                          ),
                        ),

                        Text(
                          'Schedule',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        _buildDetailRow('Date', '11 Nov, 2025', isDarkMode, width),
                        _buildDetailRow('Time', '4:30 PM – 5:30 PM', isDarkMode, width),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.014),
                          child: Divider(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                            thickness: 1,
                            height: 0,
                          ),
                        ),

                        Text(
                          'Address',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        Text(
                          '1/2 main road MG marg, Moti nagar, Delhi',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Basic Service
                  Text(
                    'Basic Service',
                    style: TextStyle(
                      fontSize: width * 0.043,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.012),

                  _buildIconCircleItem(
                    Icons.hourglass_bottom_rounded,
                    '4 Hrs Taken',
                    Colors.grey.shade200,
                    Colors.grey.shade600,
                    isDarkMode,
                    width,
                    height,
                  ),
                  _buildIconCircleItem(
                    Icons.verified_rounded,
                    '1000 kms or 3 Months Warranty',
                    Colors.green.shade100,
                    Colors.green.shade700,
                    isDarkMode,
                    width,
                    height,
                  ),
                  _buildIconCircleItem(
                    Icons.sync_rounded,
                    'Every 5000 kms or 6 Months (Recommended)',
                    Colors.orange.shade100,
                    Colors.orange.shade700,
                    isDarkMode,
                    width,
                    height,
                  ),
                  _buildIconCircleItem(
                    Icons.local_shipping_rounded,
                    'Free Pick-up & Drop',
                    Colors.blue.shade100,
                    Colors.blue.shade700,
                    isDarkMode,
                    width,
                    height,
                  ),

                  SizedBox(height: height * 0.025),

                  // What's Included
                  Text(
                    "What's Included?",
                    style: TextStyle(
                      fontSize: width * 0.043,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.014),

                  // Essential Services (image placeholders)
                  Text(
                    'Essential Services',
                    style: TextStyle(
                      fontSize: width * 0.033,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  Row(
                    children: [
                      Expanded(
                        child: _buildServiceImagePlaceholder('Engine Oil Replacement', isDarkMode, width),
                      ),
                      SizedBox(width: width * 0.025),
                      Expanded(
                        child: _buildServiceImagePlaceholder('Oil Filter Replacement', isDarkMode, width),
                      ),
                      SizedBox(width: width * 0.025),
                      Expanded(
                        child: _buildServiceImagePlaceholder('Air Filter Cleaning', isDarkMode, width),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // Additional Services (checklist)
                  Text(
                    'Additional Services',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  _buildCheckItem('4 Hrs Taken', isDarkMode, width, height),
                  _buildCheckItem('1000 kms or 3 Months Warranty', isDarkMode, width, height),
                  _buildCheckItem('Every 5000 kms or 6 Months (Recommended)', isDarkMode, width, height),
                  _buildCheckItem('Free Pick-up & Drop', isDarkMode, width, height),

                  SizedBox(height: height * 0.025),

                  // Price Details
                  Text(
                    'Price Details',
                    style: TextStyle(
                      fontSize: width * 0.043,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cardBorder, width: 1),
                    ),
                    child: Column(
                      children: [
                        _buildPriceRow('Price (2 item)', '₹14,400', isDarkMode, width),
                        _buildPriceRow('Discount', '₹2,300', isDarkMode, width),
                        _buildPriceRow('Delivery Charges', 'Free', isDarkMode, width),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.008),
                          child: Divider(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                            thickness: 1,
                            height: 0,
                          ),
                        ),

                        _buildPriceRow('Net Amount', '₹1,300', isDarkMode, width),
                        _buildPriceRow('Advance Amount (10%)', '₹1,300', isDarkMode, width),
                        SizedBox(height: height * 0.005),
                        Text(
                          '10% advance is collected to confirm the booking and assign the technician.',
                          style: TextStyle(
                            fontSize: width * 0.028,
                            color: AppColor.primary,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Divider(
                          color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                          thickness: 1,
                        ),
                        _buildPriceRow('Total', '₹12,100', isDarkMode, width, isBold: true),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Start Inspection Button
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const JobCardScreenOne()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Start inspection',
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

  Widget _buildFeatureBullet(String text, double width) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width * 0.012,
          height: width * 0.012,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: width * 0.015),
        Text(
          text,
          style: TextStyle(
            fontSize: width * 0.03,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildIconCircleItem(
      IconData icon,
      String text,
      Color bgColor,
      Color iconColor,
      bool isDarkMode,
      double width,
      double height,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.007),
      child: Row(
        children: [
          Container(
            width: width * 0.09,
            height: width * 0.09,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: width * 0.045, color: iconColor),
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: width * 0.033,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceImagePlaceholder(String label, bool isDarkMode, double width) {
    return Column(
      children: [
        // TODO: Replace with actual service image (Image.asset / Image.network)
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            height: width * 0.22,
            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
            alignment: Alignment.center,
            child: Icon(
              Icons.image_outlined,
              size: width * 0.08,
              color: isDarkMode ? Colors.white38 : Colors.grey.shade500,
            ),
          ),
        ),
        SizedBox(height: width * 0.015),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.03,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(String text, bool isDarkMode, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.007),
      child: Row(
        children: [
          Container(
            width: width * 0.05,
            height: width * 0.05,
            decoration: const BoxDecoration(
              color: Color(0xFF2FA84F),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_rounded, size: width * 0.033, color: Colors.white),
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: width * 0.033,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, bool isDarkMode, double width, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.008),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.032,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              color: isBold
                  ? (isDarkMode ? AppColor.textPrimary : Colors.black87)
                  : (isDarkMode ? AppColor.textSecondary : Colors.grey.shade600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: width * 0.032,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: isBold
                  ? AppColor.primary
                  : (isDarkMode ? AppColor.textSecondary : Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}