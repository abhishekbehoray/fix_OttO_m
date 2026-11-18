// TechnicianEditProfileScreen.dart
import 'dart:io';

import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TechnicianEditProfileScreen extends StatefulWidget {
  const TechnicianEditProfileScreen({super.key});

  @override
  State<TechnicianEditProfileScreen> createState() =>
      _TechnicianEditProfileScreenState();
}

class _TechnicianEditProfileScreenState
    extends State<TechnicianEditProfileScreen> {
  final TextEditingController _experienceController =
  TextEditingController(text: '5 years');

  String? _serviceCategory = 'Car Service';
  String? _subServices = 'Oil Change, Engine Repair, Car Washing';

  // Address proof + certificate "uploaded file" placeholders.
  String? _addressProofFileName = 'address_proof.pdf';
  String? _certificateFileName = 'mechanic_certificate.jpg';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateStatusBar());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateStatusBar();
  }

  void _updateStatusBar() {
    final isDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    ));
  }

  @override
  void dispose() {
    _experienceController.dispose();
    super.dispose();
  }

  void _pickAddressProof() {
    // TODO: hook up file/image picker.
    setState(() => _addressProofFileName = 'address_proof.pdf');
  }

  void _pickCertificate() {
    // TODO: hook up file/image picker.
    setState(() => _certificateFileName = 'mechanic_certificate.jpg');
  }

  void _onSave() {
    // TODO: submit professional details.
  }

  void _onDeleteAccount() {
    // TODO: confirm + delete account flow.
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final Color cardColor = isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white;
    final Color fieldColor = isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF6F6F8);
    final Color borderColor = isDarkMode ? Colors.white.withOpacity(0.12) : Colors.grey.shade300;
    final Color labelColor = isDarkMode ? AppColor.textSecondary : Colors.grey.shade700;
    final Color textColor = isDarkMode ? AppColor.textPrimary : const Color(0xFF1A1A1A);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: isDarkMode ? AppColor.getOnboardingGradient(brightness) : null,
          color: isDarkMode ? null : const Color(0xFFF5F5F7),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.012),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Container(
                        width: width * 0.1,
                        height: width * 0.1,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: isDarkMode
                              ? null
                              : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_back_rounded, color: textColor, size: width * 0.05),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'My Profile',
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.1),
                  ],
                ),
              ),

              // Body
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, height * 0.02),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.03, width * 0.05, height * 0.03),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Professional Details',
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.028),

                        _buildLabel('Service Category', labelColor, width),
                        SizedBox(height: height * 0.008),
                        _buildDropdownField(
                          value: _serviceCategory,
                          items: const ['Car Service', 'Bike Service', 'AC Repair'],
                          onChanged: (v) => setState(() => _serviceCategory = v),
                          fieldColor: fieldColor,
                          borderColor: borderColor,
                          textColor: textColor,
                          width: width,
                          height: height,
                        ),
                        SizedBox(height: height * 0.022),

                        _buildLabel('Sub Services', labelColor, width),
                        SizedBox(height: height * 0.008),
                        _buildDropdownField(
                          value: _subServices,
                          items: const [
                            'Oil Change, Engine Repair, Car Washing',
                            'Brake Service, Battery Check',
                          ],
                          onChanged: (v) => setState(() => _subServices = v),
                          fieldColor: fieldColor,
                          borderColor: borderColor,
                          textColor: textColor,
                          width: width,
                          height: height,
                        ),
                        SizedBox(height: height * 0.022),

                        _buildLabel('Experience', labelColor, width),
                        SizedBox(height: height * 0.008),
                        _buildTextField(
                          controller: _experienceController,
                          fieldColor: fieldColor,
                          borderColor: borderColor,
                          textColor: textColor,
                          width: width,
                          height: height,
                        ),
                        SizedBox(height: height * 0.026),

                        _buildLabel('Address Proof', labelColor, width),
                        SizedBox(height: height * 0.008),
                        _buildUploadBox(
                          onTap: _pickAddressProof,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                          width: width,
                          height: height,
                        ),
                        if (_addressProofFileName != null) ...[
                          SizedBox(height: height * 0.012),
                          _buildFilePill(
                            fileName: _addressProofFileName!,
                            onDelete: () => setState(() => _addressProofFileName = null),
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                            textColor: textColor,
                            width: width,
                            height: height,
                          ),
                        ],
                        SizedBox(height: height * 0.026),

                        _buildLabel('Certificates', labelColor, width),
                        SizedBox(height: height * 0.008),
                        _buildUploadBox(
                          onTap: _pickCertificate,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                          width: width,
                          height: height,
                        ),
                        if (_certificateFileName != null) ...[
                          SizedBox(height: height * 0.012),
                          _buildFilePill(
                            fileName: _certificateFileName!,
                            onDelete: () => setState(() => _certificateFileName = null),
                            fieldColor: fieldColor,
                            borderColor: borderColor,
                            textColor: textColor,
                            width: width,
                            height: height,
                          ),
                        ],
                        SizedBox(height: height * 0.035),

                        SizedBox(
                          width: double.infinity,
                          height: height * 0.062,
                          child: ElevatedButton(
                            onPressed: _onSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2FB84C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: width * 0.042,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _onDeleteAccount,
                      child: Text(
                        'Delete Account',
                        style: TextStyle(
                          fontSize: width * 0.033,
                          color: labelColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text('•', style: TextStyle(color: labelColor, fontSize: width * 0.033)),
                    ),
                    Text(
                      'v3.1.1.0',
                      style: TextStyle(fontSize: width * 0.033, color: labelColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color color, double width) {
    return Text(
      text,
      style: TextStyle(
        fontSize: width * 0.036,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required Color fieldColor,
    required Color borderColor,
    required Color textColor,
    required double width,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.045),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: textColor),
          style: TextStyle(
            fontSize: width * 0.04,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: fieldColor,
          items: items
              .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e, overflow: TextOverflow.ellipsis),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required Color fieldColor,
    required Color borderColor,
    required Color textColor,
    required double width,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: width * 0.04, color: textColor, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.045, vertical: height * 0.016),
        ),
      ),
    );
  }

  Widget _buildUploadBox({
    required VoidCallback onTap,
    required Color borderColor,
    required bool isDarkMode,
    required double width,
    required double height,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorderBox(
        color: borderColor,
        radius: 14,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: height * 0.03),
          alignment: Alignment.center,
          child: Column(
            children: [
              Icon(Icons.file_upload_outlined, color: isDarkMode ? Colors.white70 : Colors.grey.shade500, size: width * 0.06),
              SizedBox(height: height * 0.008),
              Text(
                'Upload a document.  JPG or PNG\nformat. Max 5MB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.033,
                  color: isDarkMode ? Colors.white60 : Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePill({
    required String fileName,
    required VoidCallback onDelete,
    required Color fieldColor,
    required Color borderColor,
    required Color textColor,
    required double width,
    required double height,
  }) {
    final bool isPdf = fileName.toLowerCase().endsWith('.pdf');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.014),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            isPdf ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
            color: const Color(0xFFE53935),
            size: width * 0.055,
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Text(
              fileName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: width * 0.037, color: textColor, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.delete_outline_rounded, color: textColor.withOpacity(0.7), size: width * 0.05),
          ),
        ],
      ),
    );
  }
}

/// Simple dashed-border container used for the upload boxes.
class DottedBorderBox extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;

  const DottedBorderBox({
    super.key,
    required this.child,
    required this.color,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: color, radius: radius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashedPath = Path();

    const double dashWidth = 6;
    const double dashSpace = 4;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final double next = distance + (draw ? dashWidth : dashSpace);
        if (draw) {
          dashedPath.addPath(
            metric.extractPath(distance, next.clamp(0, metric.length)),
            Offset.zero,
          );
        }
        distance = next;
        draw = !draw;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}