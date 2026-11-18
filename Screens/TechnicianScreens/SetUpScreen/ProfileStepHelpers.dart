import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Shared building blocks for the "Complete your profile" step screens
// (Step One → Step Four). Kept in one file so the connected step indicator,
// pill text fields, and checkbox styling stay perfectly consistent across
// every step, and to avoid duplicate top-level widget names when several
// step screens are imported together (e.g. from a router).
// ---------------------------------------------------------------------------

/// Step indicator row with connecting lines. Steps up to and including
/// [currentStep] render green (completed/active); later steps render grey.
/// A connecting line is green only when the step to its right is already
/// completed/active, matching the reference design.
Widget buildStepper(int currentStep, bool isDarkMode, double width) {
  Widget circle(int step) {
    final bool done = step <= currentStep;
    return Column(
      children: [
        Container(
          width: width * 0.12,
          height: width * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done ? AppColor.primary : (isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              step.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Step ${step.toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: width * 0.025,
            fontWeight: done ? FontWeight.w600 : FontWeight.w400,
            color: done ? AppColor.primary : (isDarkMode ? AppColor.textTertiary : Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  Widget line(int rightStep) {
    final bool done = rightStep <= currentStep;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Container(
          height: 2,
          color: done ? AppColor.primary : (isDarkMode ? Colors.white.withOpacity(0.12) : Colors.grey.shade300),
        ),
      ),
    );
  }

  return Row(
    children: [
      circle(1),
      line(2),
      circle(2),
      line(3),
      circle(3),
      line(4),
      circle(4),
    ],
  );
}

/// Full pill-shaped labelled text field used across all step screens.
Widget buildPillTextField(
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
          fontSize: width * 0.035,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
        ),
      ),
      SizedBox(height: height * 0.006),
      Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
          borderRadius: BorderRadius.circular(30),
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
            fontSize: width * 0.035,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
              fontSize: width * 0.035,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.016,
            ),
          ),
        ),
      ),
    ],
  );
}

/// Pill-shaped dropdown field (used for Vehicle Type).
Widget buildPillDropdown(
    String label,
    String value,
    List<String> options,
    bool isDarkMode,
    double width,
    double height,
    ValueChanged<String?> onChanged,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: width * 0.035,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
        ),
      ),
      SizedBox(height: height * 0.006),
      Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
          borderRadius: BorderRadius.circular(30),
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
              fontSize: width * 0.035,
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
            onChanged: onChanged,
            padding: EdgeInsets.symmetric(vertical: height * 0.016),
          ),
        ),
      ),
    ],
  );
}

/// Square checkbox + label option (used for marital status, education,
/// experience, payment mode, own tools / smartphone toggles).
Widget buildCheckboxOption(
    String label,
    bool isSelected,
    bool isDarkMode,
    double width,
    VoidCallback onTap,
    ) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width * 0.05,
          height: width * 0.05,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isSelected ? AppColor.primary : (isDarkMode ? AppColor.textTertiary : Colors.grey.shade400),
              width: 1.5,
            ),
          ),
          child: isSelected
              ? Icon(Icons.check_rounded, color: Colors.white, size: width * 0.035)
              : null,
        ),
        SizedBox(width: width * 0.02),
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.034,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
          ),
        ),
      ],
    ),
  );
}

/// Dashed-border upload box (RC photo / License photo).
Widget buildUploadBox(String label, bool isDarkMode, double width, double height, VoidCallback onTap) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: width * 0.035,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
        ),
      ),
      SizedBox(height: height * 0.008),
      GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          painter: _DashedRRectPainter(
            color: isDarkMode ? Colors.white.withOpacity(0.2) : Colors.grey.shade400,
            radius: 12,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: height * 0.03),
            child: Column(
              children: [
                Icon(
                  Icons.upload_rounded,
                  size: width * 0.08,
                  color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                ),
                SizedBox(height: height * 0.008),
                Text(
                  'Upload a document. JPG or PNG or PDF format. Max 5MB',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.028,
                    color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashGap;

  _DashedRRectPainter({
    required this.color,
    this.radius = 12,
    this.dashWidth = 6,
    this.dashGap = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.7, 0.7, size.width - 1.4, size.height - 1.4),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}