// TechnicianJobDetailScreenThree.dart
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

import 'TechnicianJobDetailScreenFour.dart';

class TechnicianJobDetailScreenThree extends StatefulWidget {
  const TechnicianJobDetailScreenThree({super.key});

  @override
  State<TechnicianJobDetailScreenThree> createState() => _TechnicianJobDetailScreenThreeState();
}

class _TechnicianJobDetailScreenThreeState extends State<TechnicianJobDetailScreenThree> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.015),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: width * 0.1,
                      height: width * 0.1,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade100,
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
                    child: Text(
                      'Basic Service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.1,
                    height: width * 0.1,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                      size: width * 0.045,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Hero Image with overlay text ──
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          height: height * 0.22,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade200,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.car_repair_rounded,
                                  size: width * 0.14,
                                  color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade400,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.all(width * 0.03),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.55),
                                      ],
                                    ),
                                  ),
                                  child: Wrap(
                                    spacing: width * 0.04,
                                    runSpacing: height * 0.004,
                                    children: const [
                                      _FeatureTag(text: 'Boosts Engine Performance'),
                                      _FeatureTag(text: '15% Milage Increase'),
                                      _FeatureTag(text: 'Improves Vehicle Life'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.018),

                      // Booking ID
                      Text(
                        'Booking ID - BK1023',
                        style: TextStyle(
                          fontSize: width * 0.033,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        ),
                      ),

                      SizedBox(height: height * 0.012),

                      // ── Customer Details / Schedule card ──
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSectionTitle('Customer Details', isDarkMode, width),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.025,
                                    vertical: height * 0.003,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFA500).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Ongoing',
                                    style: TextStyle(
                                      fontSize: width * 0.028,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFFFA500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.012),
                            _buildDetailRow('Name', 'Rahul Sharma', isDarkMode, width, height),
                            _buildDetailRow('Phone Number', '+91 8023993884', isDarkMode, width, height),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.012),
                              child: Divider(
                                height: 1,
                                color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                              ),
                            ),

                            _buildSectionTitle('Schedule', isDarkMode, width),
                            SizedBox(height: height * 0.01),
                            _buildDetailRow('Date', '11 Nov, 2025', isDarkMode, width, height),
                            _buildDetailRow('Time', '4:30 PM – 5:30 PM', isDarkMode, width, height),
                          ],
                        ),
                      ),

                      SizedBox(height: height * 0.02),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                      ),
                      SizedBox(height: height * 0.02),

                      // ── Address (outside card) ──
                      _buildSectionTitle('Address', isDarkMode, width),
                      SizedBox(height: height * 0.008),
                      Text(
                        '1/2 main road MG marg, Moti nagar, Delhi',
                        style: TextStyle(
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: height * 0.015),

                      // ── Map placeholder card with Location overlay ──
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          height: height * 0.22,
                          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade100,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Icon(
                                  Icons.map_outlined,
                                  size: width * 0.5,
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.04)
                                      : Colors.grey.shade200,
                                ),
                              ),
                              Positioned(
                                top: height * 0.015,
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        fontSize: width * 0.038,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF2FB84C),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.003),
                                    Text(
                                      '1/2 main road MG marg, Moti nagar, Delhi',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width * 0.032,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Icon(
                                  Icons.location_on,
                                  color: const Color(0xFFE74C3C),
                                  size: width * 0.09,
                                ),
                              ),
                              Positioned(
                                bottom: height * 0.015,
                                right: width * 0.03,
                                child: GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Opening map...'),
                                        backgroundColor: AppColor.primary,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.035,
                                      vertical: height * 0.008,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'View Map',
                                          style: TextStyle(
                                            fontSize: width * 0.032,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF2FB84C),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.01),
                                        const Icon(
                                          Icons.chevron_right_rounded,
                                          color: Color(0xFF2FB84C),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.025),

                      // ── Inspection (single camera box, no image, no submit) ──
                      _buildSectionTitle('Inspection', isDarkMode, width),
                      SizedBox(height: height * 0.012),
                      _buildCameraOnlyBox(isDarkMode, width, height),

                      SizedBox(height: height * 0.02),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                      ),
                      SizedBox(height: height * 0.02),

                      // ── Work Progress ──
                      _buildSectionTitle('Work Progress', isDarkMode, width),
                      SizedBox(height: height * 0.015),

                      _buildWorkProgressItem(
                        1,
                        'Engine Oil Replacement',
                        isDarkMode,
                        width,
                        height,
                      ),
                      SizedBox(height: height * 0.02),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                      ),
                      SizedBox(height: height * 0.02),

                      _buildWorkProgressItem(
                        2,
                        'Oil Filter Replacement',
                        isDarkMode,
                        width,
                        height,
                      ),
                      SizedBox(height: height * 0.02),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                      ),
                      SizedBox(height: height * 0.02),

                      _buildWorkProgressItem(
                        3,
                        'Air Filter Cleaning',
                        isDarkMode,
                        width,
                        height,
                      ),

                      SizedBox(height: height * 0.02),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                      ),
                      SizedBox(height: height * 0.02),

                      // ── Price Details card ──
                      _buildSectionTitle('Price Details', isDarkMode, width),
                      SizedBox(height: height * 0.012),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPriceRow('Price (2 item)', '₹ 14,400', isDarkMode, width),
                            _buildPriceRow('Discount', '₹ 2,300', isDarkMode, width),
                            _buildPriceRow('Delivery Charges', 'Free', isDarkMode, width),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Divider(
                                height: 1,
                                color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                              ),
                            ),

                            _buildPriceRow('Net Amount', '₹ 1,300', isDarkMode, width),

                            SizedBox(height: height * 0.01),

                            _buildPriceRow('Advance Amount (10%)', '₹ 1,300', isDarkMode, width, isBold: true),
                            SizedBox(height: height * 0.004),
                            Text(
                              '10% advance is collected to confirm the booking and assign the technician.',
                              style: TextStyle(
                                fontSize: width * 0.028,
                                color: AppColor.primary,
                                height: 1.4,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.012),
                              child: Divider(
                                height: 1,
                                color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: width * 0.042,
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                                  ),
                                ),
                                Text(
                                  '₹ 12,100',
                                  style: TextStyle(
                                    fontSize: width * 0.042,
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: height * 0.03),

                      // ── Enter OTP & complete job Button ──
                      SizedBox(
                        width: double.infinity,
                        height: height * 0.062,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TechnicianJobDetailScreenFour(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Enter OTP & complete job',
                            style: TextStyle(
                              fontSize: width * 0.04,
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
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode, double width) {
    return Text(
      title,
      style: TextStyle(
        fontSize: width * 0.04,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode, double width, double height) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.32,
            child: Text(
              label,
              style: TextStyle(
                fontSize: width * 0.033,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: width * 0.033,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Single dashed camera box used for the top-level "Inspection" section
  Widget _buildCameraOnlyBox(bool isDarkMode, double width, double height) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening camera...'),
            backgroundColor: AppColor.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: DottedBox(
        isDarkMode: isDarkMode,
        height: height * 0.11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              size: width * 0.06,
            ),
            SizedBox(height: height * 0.006),
            Text(
              'Camera',
              style: TextStyle(
                fontSize: width * 0.033,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Numbered Work Progress item: title, image thumbnail, camera/upload row, submit button
  Widget _buildWorkProgressItem(
      int number,
      String title,
      bool isDarkMode,
      double width,
      double height,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. $title',
          style: TextStyle(
            fontSize: width * 0.036,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
          ),
        ),
        SizedBox(height: height * 0.01),

        // Image thumbnail placeholder
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            height: height * 0.16,
            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
            child: Icon(
              Icons.car_repair_rounded,
              size: width * 0.1,
              color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade400,
            ),
          ),
        ),
        SizedBox(height: height * 0.012),

        // Camera / Upload image row
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening camera...'),
                      backgroundColor: AppColor.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: DottedBox(
                  isDarkMode: isDarkMode,
                  height: height * 0.09,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        size: width * 0.055,
                      ),
                      SizedBox(height: height * 0.005),
                      Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: width * 0.025),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Uploading image...'),
                      backgroundColor: AppColor.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: DottedBox(
                  isDarkMode: isDarkMode,
                  height: height * 0.09,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        size: width * 0.055,
                      ),
                      SizedBox(height: height * 0.005),
                      Text(
                        'Upload image',
                        style: TextStyle(
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.012),

        // Submit button (outlined, full-width, green text)
        SizedBox(
          width: double.infinity,
          height: height * 0.052,
          child: OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Submitted successfully!'),
                  backgroundColor: AppColor.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF2FB84C), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2FB84C),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, bool isDarkMode, double width, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.033,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: width * 0.033,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Dashed-border container used for camera/upload placeholders
class DottedBox extends StatelessWidget {
  final Widget child;
  final double height;
  final bool isDarkMode;

  const DottedBox({
    super.key,
    required this.child,
    required this.height,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(isDarkMode: isDarkMode),
      child: Container(
        width: double.infinity,
        height: height,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final bool isDarkMode;
  _DashedBorderPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isDarkMode ? Colors.white.withOpacity(0.15) : Colors.grey.shade400
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const double radius = 12;
    const double dashWidth = 5;
    const double dashSpace = 4;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashedPath = Path();

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = distance + dashWidth;
        dashedPath.addPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          Offset.zero,
        );
        distance = next + dashSpace;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FeatureTag extends StatelessWidget {
  final String text;
  const _FeatureTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.circle, color: Colors.white, size: 5),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}