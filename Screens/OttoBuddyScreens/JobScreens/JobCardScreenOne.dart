import 'dart:ui';

import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/JobScreens/JobCardScreenTwo.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class JobCardScreenOne extends StatefulWidget {
  const JobCardScreenOne({super.key});

  @override
  State<JobCardScreenOne> createState() => _JobCardScreenOneState();
}

class _JobCardScreenOneState extends State<JobCardScreenOne> {
  String _status = 'New';

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
                            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.white,
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

                  // Job Card Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.045),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cardBorder, width: 1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Job Card',
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        Row(
                          children: [
                            Image.asset(
                              ImageAssets.statsImage,
                              width: width * 0.2,
                              height: width * 0.2,
                              fit: BoxFit.contain,

                            ),
                            SizedBox(width: width * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fixotto',
                                  style: TextStyle(
                                    fontSize: width * 0.042,
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
                  ),

                  SizedBox(height: height * 0.02),

                  // Consolidated Details Card
                  Container(
                    padding: EdgeInsets.all(width * 0.045),
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
                        _buildStatusRow('Status', _status, isDarkMode, width, height),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.014),
                          child: Divider(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                            thickness: 1,
                            height: 0,
                          ),
                        ),

                        _buildSectionTitle('Vehicle Info', isDarkMode, width),
                        _buildDetailRow('Vehicle Number', 'DI XX D5 1200', isDarkMode, width),
                        _buildDetailRow('Vehicle Type', 'Lorem Ipsum', isDarkMode, width),
                        _buildDetailRow('Model Number', 'Lorem Ipsum', isDarkMode, width),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.014),
                          child: Divider(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                            thickness: 1,
                            height: 0,
                          ),
                        ),

                        _buildSectionTitle('Service Info', isDarkMode, width),
                        _buildDetailRow('Service Name', 'Lorem Ipsum', isDarkMode, width),
                        _buildDetailRow('Package', 'Lorem Ipsum', isDarkMode, width),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Inspection
                  Text(
                    'Inspection',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JobCardScreenTwo(),
                        ),
                      );
                    },
                    child: CustomPaint(
                      painter: _DashedBorderPainter(
                        color: isDarkMode ? Colors.white.withOpacity(0.2) : Colors.grey.shade300,
                        radius: 14,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: height * 0.035),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                              size: width * 0.07,
                            ),
                            SizedBox(height: height * 0.008),
                            Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Confirm & Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JobCardScreenTwo(),
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
                        'Confirm & Continue',
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

  Widget _buildSectionTitle(String title, bool isDarkMode, double width) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.015),
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

  Widget _buildStatusRow(String label, String value, bool isDarkMode, double width, double height) {
    final bool isNew = value == 'New';
    final Color statusColor = isNew ? const Color(0xFF1E88E5) : Colors.green;

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
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.004,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
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
}

/// Simple dashed rounded-rectangle border painter used for the Camera
/// upload placeholder box.
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  const _DashedBorderPainter({
    required this.color,
    this.radius = 12,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.strokeWidth = 1.2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      old.color != color || old.radius != radius;
}