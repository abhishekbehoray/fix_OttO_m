// TechnicianJobDetailScreenFour.dart
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'TechnicianJobSuccessScreen.dart';

class TechnicianJobDetailScreenFour extends StatefulWidget {
  const TechnicianJobDetailScreenFour({super.key});

  @override
  State<TechnicianJobDetailScreenFour> createState() => _TechnicianJobDetailScreenFourState();
}

class _TechnicianJobDetailScreenFourState extends State<TechnicianJobDetailScreenFour> {

  void _showOtpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (_) => const _OtpBottomSheet(),
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

                      SizedBox(height: height * 0.03),

                      // ── Enter OTP Button ──
                      SizedBox(
                        width: double.infinity,
                        height: height * 0.062,
                        child: ElevatedButton(
                          onPressed: () => _showOtpSheet(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2FB84C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Enter OTP',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.03),
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

// ─────────────────────────────────────────────────────────
// Bottom sheet: Enter OTP + Swipe to Start
// ─────────────────────────────────────────────────────────
class _OtpBottomSheet extends StatefulWidget {
  const _OtpBottomSheet();

  @override
  State<_OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<_OtpBottomSheet> {
  static const int otpLength = 6;
  final List<TextEditingController> _controllers =
  List.generate(otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(otpLength, (_) => FocusNode());

  double _dragExtent = 0;
  bool _isCompleting = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpValue => _controllers.map((c) => c.text).join();

  bool get _isOtpComplete => _otpValue.length == otpLength;

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  void _completeAndNavigate() {
    if (_isCompleting) return;
    if (!_isOtpComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the full 6-digit OTP'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() => _dragExtent = 0);
      return;
    }
    _isCompleting = true;

    Navigator.pop(context); // close the sheet
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const TechnicianJobSuccessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double sheetPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: sheetPadding),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        padding: EdgeInsets.fromLTRB(width * 0.06, height * 0.025, width * 0.06, height * 0.035),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: width * 0.1,
                height: 4,
                margin: EdgeInsets.only(bottom: height * 0.02),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white.withOpacity(0.2) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
              ),
            ),
            SizedBox(height: height * 0.02),

            // 6 individual OTP boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(otpLength, (index) {
                return SizedBox(
                  width: width * 0.115,
                  height: width * 0.13,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDarkMode ? Colors.white.withOpacity(0.15) : Colors.grey.shade300,
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF2FB84C),
                          width: 1.5,
                        ),
                      ),
                    ),
                    onChanged: (value) => _onDigitChanged(index, value),
                  ),
                );
              }),
            ),

            SizedBox(height: height * 0.035),

            // Swipe to Start slider
            _buildSwipeSlider(isDarkMode, width, height),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeSlider(bool isDarkMode, double width, double height) {
    final double trackWidth = width * 0.88 - width * 0.12; // sheet padding accounted for
    final double sliderHeight = height * 0.065;
    final double handleSize = sliderHeight - 8;
    final double maxDrag = trackWidth - handleSize - 8;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double effectiveMaxDrag = constraints.maxWidth - handleSize - 8;
        return Container(
          width: double.infinity,
          height: sliderHeight,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2FB84C), Color(0xFF1E8E3E)],
            ),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2FB84C).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: Text(
                  'Swipe to Start',
                  style: TextStyle(
                    fontSize: width * 0.038,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: _isCompleting ? const Duration(milliseconds: 200) : Duration.zero,
                left: 4 + _dragExtent,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _dragExtent += details.delta.dx;
                      _dragExtent = _dragExtent.clamp(0, effectiveMaxDrag);
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_dragExtent >= effectiveMaxDrag * 0.85) {
                      setState(() => _dragExtent = effectiveMaxDrag);
                      _completeAndNavigate();
                    } else {
                      setState(() => _dragExtent = 0);
                    }
                  },
                  child: Container(
                    width: handleSize,
                    height: handleSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      color: Color(0xFF2FB84C),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}