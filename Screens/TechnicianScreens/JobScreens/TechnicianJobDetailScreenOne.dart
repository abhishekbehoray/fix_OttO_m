// TechnicianJobDetailScreenOne.dart
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/JobScreens/TechnicianJobRejectedScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'TechnicianJobDetailScreenTwo.dart';

class TechnicianJobDetailScreenOne extends StatefulWidget {
  final String jobId;
  final bool showAcceptButton;
  final bool showEnterOtpButton;

  const TechnicianJobDetailScreenOne({
    super.key,
    required this.jobId,
    this.showAcceptButton = true,
    this.showEnterOtpButton = false,
  });

  @override
  State<TechnicianJobDetailScreenOne> createState() => _TechnicianJobDetailScreenOneState();
}

class _TechnicianJobDetailScreenOneState extends State<TechnicianJobDetailScreenOne> {

  void _showOtpSheet(BuildContext context, double width, double height, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (_) => _OtpBottomSheet(
        onConfirmed: () {
          Navigator.pop(context); // close sheet
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TechnicianJobRejectedScreen()),
          );
        },
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
                              // Gradient for text legibility
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
                        'Booking ID - ${widget.jobId}',
                        style: TextStyle(
                          fontSize: width * 0.033,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        ),
                      ),

                      SizedBox(height: height * 0.012),

                      // ── Customer Details / Schedule / Address card ──
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
                                    color: AppColor.primary.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'New',
                                    style: TextStyle(
                                      fontSize: width * 0.028,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primary,
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

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.012),
                              child: Divider(
                                height: 1,
                                color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                              ),
                            ),

                            _buildSectionTitle('Address', isDarkMode, width),
                            SizedBox(height: height * 0.008),
                            Text(
                              '1/2 main road MG marg, Moti nagar, Delhi',
                              style: TextStyle(
                                fontSize: width * 0.033,
                                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: height * 0.025),

                      // ── Basic Service Details ──
                      _buildSectionTitle('Basic Service', isDarkMode, width),
                      SizedBox(height: height * 0.012),
                      _buildServiceDetailItem(Icons.hourglass_bottom_rounded, '4 Hrs Taken', isDarkMode, width),
                      _buildServiceDetailItem(Icons.shield_outlined, '1000 kms or 3 Months Warranty', isDarkMode, width),
                      _buildServiceDetailItem(Icons.back_hand_outlined, 'Every 5000 kms or 6 Months (Recommended)', isDarkMode, width),
                      _buildServiceDetailItem(Icons.location_on_outlined, 'Free Pick-up & Drop', isDarkMode, width),

                      SizedBox(height: height * 0.02),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                      ),
                      SizedBox(height: height * 0.02),

                      // ── What's Included ──
                      _buildSectionTitle('What\'s Included?', isDarkMode, width),
                      SizedBox(height: height * 0.014),
                      _buildSubSectionTitle('Essential Services', isDarkMode, width),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: _buildServiceImageItem('Engine Oil\nReplacement', isDarkMode, width),
                          ),
                          SizedBox(width: width * 0.025),
                          Expanded(
                            child: _buildServiceImageItem('Oil Filter\nReplacement', isDarkMode, width),
                          ),
                          SizedBox(width: width * 0.025),
                          Expanded(
                            child: _buildServiceImageItem('Air Filter\nCleaning', isDarkMode, width),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.02),
                      Divider(
                        height: 1,
                        color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                      ),
                      SizedBox(height: height * 0.02),

                      _buildSubSectionTitle('Additional Services', isDarkMode, width),
                      _buildIncludedItem('4 Hrs Taken', isDarkMode, width),
                      _buildIncludedItem('1000 kms or 3 Months Warranty', isDarkMode, width),
                      _buildIncludedItem('Every 5000 kms or 6 Months (Recommended)', isDarkMode, width),
                      _buildIncludedItem('Free Pick-up & Drop', isDarkMode, width),

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

                            // Advance Amount note
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

                            // Total
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

                      // ── Accept Job Button ──
                      if (widget.showAcceptButton) ...[
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.062,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const TechnicianJobDetailScreenTwo(),
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
                              'Accept Job',
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

                      // ── Enter OTP Button (Rejected) ──
                      if (widget.showEnterOtpButton) ...[
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.062,
                          child: ElevatedButton(
                            onPressed: () => _showOtpSheet(context, width, height, isDarkMode),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
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
                        SizedBox(height: height * 0.02),
                      ],
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

  Widget _buildSubSectionTitle(String title, bool isDarkMode, double width) {
    return Text(
      title,
      style: TextStyle(
        fontSize: width * 0.035,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
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

  Widget _buildServiceDetailItem(IconData icon, String text, bool isDarkMode, double width) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.03),
      child: Row(
        children: [
          Container(
            width: width * 0.08,
            height: width * 0.08,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade500,
              size: width * 0.04,
            ),
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

  Widget _buildServiceImageItem(String label, bool isDarkMode, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            height: width * 0.22,
            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
            child: Icon(
              Icons.car_repair_rounded,
              size: width * 0.08,
              color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade400,
            ),
          ),
        ),
        SizedBox(height: width * 0.015),
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.03,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildIncludedItem(String text, bool isDarkMode, double width) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.025),
      child: Row(
        children: [
          Container(
            width: width * 0.05,
            height: width * 0.05,
            decoration: const BoxDecoration(
              color: Color(0xFF2FB84C),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: width * 0.032,
            ),
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

// ── OTP Bottom Sheet ──
class _OtpBottomSheet extends StatefulWidget {
  final VoidCallback onConfirmed;
  const _OtpBottomSheet({required this.onConfirmed});

  @override
  State<_OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<_OtpBottomSheet> {
  static const int _len = 4;
  final List<TextEditingController> _controllers =
  List.generate(_len, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(_len, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < _len - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: EdgeInsets.fromLTRB(
            width * 0.06, height * 0.025, width * 0.06, height * 0.04),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: width * 0.1,
                height: 4,
                margin: EdgeInsets.only(bottom: height * 0.02),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.2)
                      : Colors.grey.shade300,
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
            SizedBox(height: height * 0.008),
            Text(
              'Enter the 4-digit OTP to confirm return',
              style: TextStyle(
                fontSize: width * 0.033,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_len, (i) {
                return SizedBox(
                  width: width * 0.18,
                  height: width * 0.18,
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.15)
                              : Colors.grey.shade300,
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            color: Color(0xFF2FB84C), width: 1.8),
                      ),
                    ),
                    onChanged: (v) => _onChanged(i, v),
                  ),
                );
              }),
            ),
            SizedBox(height: height * 0.03),
            SizedBox(
              width: double.infinity,
              height: height * 0.062,
              child: ElevatedButton(
                onPressed: () {
                  if (_otp.length < _len) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter the full OTP'),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }
                  widget.onConfirmed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: Text(
                  'Reject Job',
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}