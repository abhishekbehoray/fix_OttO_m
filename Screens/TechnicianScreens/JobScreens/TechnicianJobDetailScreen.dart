// TechnicianJobDetailScreen.dart
//
// Merged version of:
//   TechnicianJobDetailScreenOne.dart
//   TechnicianJobDetailScreenTwo.dart
//   TechnicianJobDetailScreenThree.dart
//   TechnicianJobDetailScreenFour.dart
//
// All four "steps" now live on a single scrollable screen. Instead of
// pushing a new route, each action button reveals the next block of
// widgets further down the same page (progressive disclosure driven by
// a `JobStage` enum). Once the job is accepted, a "View Store" button
// appears above the Address section; the map itself is still reachable
// via the "View Map" pill on the map card.

import 'package:fixottobuddy_techni/Screens/TechnicianScreens/JobScreens/TechnicianJobRejectedScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/StoreScreens/TechnicianStoreScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'TechnicianJobSuccessScreen.dart';

/// Progress of the job on this single merged screen.
/// Each stage unlocks (reveals) the widgets that used to live on the
/// corresponding standalone screen.
enum JobStage {
  newJob,
  accepted,
  reached,
  completed,
}

class TechnicianJobDetailScreen extends StatefulWidget {
  final String jobId;
  final String customerName;
  final String customerPhone;
  final String scheduleDate;
  final String scheduleTime;
  final String address;

  /// Same meaning as the old ScreenOne flags — pass these straight from
  /// your job-list `status` field:
  ///   showAcceptButton:   status != 'Completed' && status != 'Rejected'
  ///   showEnterOtpButton: status == 'Rejected'
  /// showAcceptButton drives the "Accept Job" button on the first stage.
  /// showEnterOtpButton shows the "Enter OTP" (reject-confirm) button
  /// instead. If both are false (i.e. status == 'Completed'), the screen
  /// opens with every stage already expanded, read-only, no action buttons.
  final bool showAcceptButton;
  final bool showEnterOtpButton;
  final JobStage? initialStage;

  const TechnicianJobDetailScreen({
    super.key,
    required this.jobId,
    this.customerName = 'Rahul Sharma',
    this.customerPhone = '+91 8023993884',
    this.scheduleDate = '11 Nov, 2025',
    this.scheduleTime = '4:30 PM – 5:30 PM',
    this.address = '1/2 main road MG marg, Moti nagar, Delhi',
    this.showAcceptButton = true,
    this.showEnterOtpButton = false,
    this.initialStage,
  });

  @override
  State<TechnicianJobDetailScreen> createState() => _TechnicianJobDetailScreenState();
}

class _TechnicianJobDetailScreenState extends State<TechnicianJobDetailScreen> {
  late JobStage _stage;

  @override
  void initState() {
    super.initState();
    // If neither action button applies, the job is already resolved
    // (e.g. status == 'Completed') — open fully expanded, read-only.
    if (widget.initialStage != null) {
      _stage = widget.initialStage!;
    } else {
      _stage = (!widget.showAcceptButton && !widget.showEnterOtpButton)
          ? JobStage.completed
          : JobStage.newJob;
    }
  }

  // ── Stage transitions ──────────────────────────────────────────────

  void _acceptJob() => setState(() => _stage = JobStage.accepted);

  void _reachedLocation() => setState(() => _stage = JobStage.reached);

  void _completeJob() => setState(() => _stage = JobStage.completed);

  // ── Bottom sheets ───────────────────────────────────────────────────

  void _showRejectOtpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (_) => _RejectOtpBottomSheet(
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

  void _showCompleteOtpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (_) => _CompleteOtpBottomSheet(
        onConfirmed: () {
          Navigator.pop(context); // close sheet
          _completeJob();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const TechnicianJobSuccessScreen()),
          );
        },
      ),
    );
  }

  void _showMapSheet(BuildContext context, double width, double height, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _buildMapCard(context, width, height * 0.55, isDarkMode, expanded: true),
        ),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final String statusLabel = switch (_stage) {
      JobStage.newJob => 'New',
      JobStage.accepted => 'Ongoing',
      JobStage.reached => 'Ongoing',
      JobStage.completed => 'Completed',
    };
    final Color statusColor = switch (_stage) {
      JobStage.newJob => AppColor.primary,
      JobStage.accepted => const Color(0xFFFFA500),
      JobStage.reached => const Color(0xFFFFA500),
      JobStage.completed => const Color(0xFF2FB84C),
    };

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header (fixed) ──
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

            // ── Scrollable content ──
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Hero Image with overlay text (always) ──
                      _buildHeroImage(width, height, isDarkMode),

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

                      // ── Customer Details / Schedule card (always) ──
                      _buildCustomerCard(width, height, isDarkMode, statusLabel, statusColor),

                      SizedBox(height: height * 0.025),

                      // ── STAGE 1 (newJob): service details, what's included, price, accept/reject ──
                      _buildSectionTitle('Basic Service', isDarkMode, width),
                      SizedBox(height: height * 0.012),
                      _buildServiceDetailItem(Icons.hourglass_bottom_rounded, '4 Hrs Taken', isDarkMode, width),
                      _buildServiceDetailItem(Icons.shield_outlined, '1000 kms or 3 Months Warranty', isDarkMode, width),
                      _buildServiceDetailItem(Icons.back_hand_outlined, 'Every 5000 kms or 6 Months (Recommended)', isDarkMode, width),
                      _buildServiceDetailItem(Icons.location_on_outlined, 'Free Pick-up & Drop', isDarkMode, width),

                      SizedBox(height: height * 0.02),
                      _divider(isDarkMode),
                      SizedBox(height: height * 0.02),

                      _buildSectionTitle('What\'s Included?', isDarkMode, width),
                      SizedBox(height: height * 0.014),
                      _buildSubSectionTitle('Essential Services', isDarkMode, width),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          Expanded(child: _buildServiceImageItem('Engine Oil\nReplacement', isDarkMode, width)),
                          SizedBox(width: width * 0.025),
                          Expanded(child: _buildServiceImageItem('Oil Filter\nReplacement', isDarkMode, width)),
                          SizedBox(width: width * 0.025),
                          Expanded(child: _buildServiceImageItem('Air Filter\nCleaning', isDarkMode, width)),
                        ],
                      ),

                      SizedBox(height: height * 0.02),
                      _divider(isDarkMode),
                      SizedBox(height: height * 0.02),

                      _buildSubSectionTitle('Additional Services', isDarkMode, width),
                      _buildIncludedItem('4 Hrs Taken', isDarkMode, width),
                      _buildIncludedItem('1000 kms or 3 Months Warranty', isDarkMode, width),
                      _buildIncludedItem('Every 5000 kms or 6 Months (Recommended)', isDarkMode, width),
                      _buildIncludedItem('Free Pick-up & Drop', isDarkMode, width),

                      SizedBox(height: height * 0.02),
                      _divider(isDarkMode),
                      SizedBox(height: height * 0.02),

                      _buildSectionTitle('Price Details', isDarkMode, width),
                      SizedBox(height: height * 0.012),
                      _buildPriceCard(width, height, isDarkMode),

                      SizedBox(height: height * 0.03),

                      // Accept Job button — only while stage == newJob and status allows it
                      if (_stage == JobStage.newJob && widget.showAcceptButton) ...[
                        _buildPrimaryButton(context, 'Accept Job', width, height, _acceptJob),
                        SizedBox(height: height * 0.02),
                      ],

                      // Enter OTP (reject-confirm) button — status == 'Rejected'
                      if (_stage == JobStage.newJob && widget.showEnterOtpButton) ...[
                        _buildPrimaryButton(
                          context,
                          'Enter OTP',
                          width,
                          height,
                              () => _showRejectOtpSheet(context),
                        ),
                        SizedBox(height: height * 0.02),
                      ],

                      // ── STAGE 2 (accepted+): view store + address + map card + reached button ──
                      if (_stage.index >= JobStage.accepted.index) ...[
                        _divider(isDarkMode),
                        SizedBox(height: height * 0.02),
                        _buildViewStoreButton(context, width, height, isDarkMode),
                        SizedBox(height: height * 0.02),
                        _buildSectionTitle('Address', isDarkMode, width),
                        SizedBox(height: height * 0.008),
                        Text(
                          widget.address,
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        _buildMapCard(context, width, height * 0.24, isDarkMode),
                        SizedBox(height: height * 0.03),
                        if (_stage == JobStage.accepted) ...[
                          _buildPrimaryButton(context, 'Reached Location', width, height, _reachedLocation),
                          SizedBox(height: height * 0.02),
                        ],
                      ],

                      // ── STAGE 3 (reached+): inspection + work progress + complete button ──
                      if (_stage.index >= JobStage.reached.index) ...[
                        _divider(isDarkMode),
                        SizedBox(height: height * 0.02),
                        _buildSectionTitle('Inspection', isDarkMode, width),
                        SizedBox(height: height * 0.012),
                        _buildCameraOnlyBox(isDarkMode, width, height),

                        SizedBox(height: height * 0.02),
                        _divider(isDarkMode),
                        SizedBox(height: height * 0.02),

                        _buildSectionTitle('Work Progress', isDarkMode, width),
                        SizedBox(height: height * 0.015),
                        _buildWorkProgressItem(1, 'Engine Oil Replacement', isDarkMode, width, height),
                        SizedBox(height: height * 0.02),
                        _divider(isDarkMode),
                        SizedBox(height: height * 0.02),
                        _buildWorkProgressItem(2, 'Oil Filter Replacement', isDarkMode, width, height),
                        SizedBox(height: height * 0.02),
                        _divider(isDarkMode),
                        SizedBox(height: height * 0.02),
                        _buildWorkProgressItem(3, 'Air Filter Cleaning', isDarkMode, width, height),

                        SizedBox(height: height * 0.03),

                        if (_stage == JobStage.reached) ...[
                          _buildPrimaryButton(
                            context,
                            'Enter OTP & complete job',
                            width,
                            height,
                                () => _showCompleteOtpSheet(context),
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      ],

                      // ── STAGE 4 (completed): confirmation banner ──
                      if (_stage == JobStage.completed) ...[
                        _divider(isDarkMode),
                        SizedBox(height: height * 0.02),
                        _buildCompletedBanner(width, height, isDarkMode),
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

  Widget _buildViewStoreButton(BuildContext context, double width, double height, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TechnicianStoreScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.012),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.08,
              height: width * 0.08,
              decoration: BoxDecoration(
                color: const Color(0xFF2FB84C).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.storefront_outlined, color: const Color(0xFF2FB84C), size: width * 0.045),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: Text(
                'View Store',
                style: TextStyle(
                  fontSize: width * 0.036,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade500, size: width * 0.05),
          ],
        ),
      ),
    );
  }

  // ── Reusable section builders ────────────────────────────────────────

  Widget _buildHeroImage(double width, double height, bool isDarkMode) {
    return ClipRRect(
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
                    colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
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
    );
  }

  Widget _buildCustomerCard(double width, double height, bool isDarkMode, String statusLabel, Color statusColor) {
    return Container(
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
                padding: EdgeInsets.symmetric(horizontal: width * 0.025, vertical: height * 0.003),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(fontSize: width * 0.028, fontWeight: FontWeight.w600, color: statusColor),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.012),
          _buildDetailRow('Name', widget.customerName, isDarkMode, width, height),
          _buildDetailRow('Phone Number', widget.customerPhone, isDarkMode, width, height),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.012),
            child: _divider(isDarkMode),
          ),
          _buildSectionTitle('Schedule', isDarkMode, width),
          SizedBox(height: height * 0.01),
          _buildDetailRow('Date', widget.scheduleDate, isDarkMode, width, height),
          _buildDetailRow('Time', widget.scheduleTime, isDarkMode, width, height),
        ],
      ),
    );
  }

  Widget _buildPriceCard(double width, double height, bool isDarkMode) {
    return Container(
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
          Padding(padding: EdgeInsets.symmetric(vertical: height * 0.01), child: _divider(isDarkMode)),
          _buildPriceRow('Net Amount', '₹ 1,300', isDarkMode, width),
          SizedBox(height: height * 0.01),
          _buildPriceRow('Advance Amount (10%)', '₹ 1,300', isDarkMode, width, isBold: true),
          SizedBox(height: height * 0.004),
          Text(
            '10% advance is collected to confirm the booking and assign the technician.',
            style: TextStyle(fontSize: width * 0.028, color: AppColor.primary, height: 1.4),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: height * 0.012), child: _divider(isDarkMode)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',
                  style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87)),
              Text('₹ 12,100',
                  style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapCard(BuildContext context, double width, double cardHeight, bool isDarkMode, {bool expanded = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: cardHeight,
        color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade100,
        child: Stack(
          children: [
            Positioned.fill(
              child: Icon(
                Icons.map_outlined,
                size: width * 0.5,
                color: isDarkMode ? Colors.white.withOpacity(0.04) : Colors.grey.shade200,
              ),
            ),
            Positioned(
              top: cardHeight * 0.08,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontSize: width * 0.038, fontWeight: FontWeight.w700, color: const Color(0xFF2FB84C)),
                  ),
                  SizedBox(height: cardHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                    child: Text(
                      widget.address,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.032,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Icon(Icons.location_on, color: const Color(0xFFE74C3C), size: width * 0.09),
            ),
            if (!expanded)
              Positioned(
                bottom: cardHeight * 0.06,
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
                    padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: cardHeight * 0.03),
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('View Map',
                            style: TextStyle(fontSize: width * 0.032, fontWeight: FontWeight.w600, color: const Color(0xFF2FB84C))),
                        SizedBox(width: width * 0.01),
                        const Icon(Icons.chevron_right_rounded, color: Color(0xFF2FB84C), size: 16),
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

  Widget _buildCompletedBanner(double width, double height, bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFF2FB84C).withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2FB84C).withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: Color(0xFF2FB84C)),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Text(
              'Job completed successfully.',
              style: TextStyle(fontSize: width * 0.035, fontWeight: FontWeight.w600, color: const Color(0xFF2FB84C)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, String label, double width, double height, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: height * 0.062,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: Text(label, style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
    );
  }

  Widget _divider(bool isDarkMode) => Divider(
    height: 1,
    color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
  );

  Widget _buildSectionTitle(String title, bool isDarkMode, double width) {
    return Text(
      title,
      style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w700, color: isDarkMode ? AppColor.textPrimary : Colors.black87),
    );
  }

  Widget _buildSubSectionTitle(String title, bool isDarkMode, double width) {
    return Text(
      title,
      style: TextStyle(fontSize: width * 0.035, fontWeight: FontWeight.w600, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600),
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
            child: Text(label,
                style: TextStyle(fontSize: width * 0.033, fontWeight: FontWeight.w500, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600)),
          ),
          Expanded(
            child: Text(value,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: width * 0.033, fontWeight: FontWeight.w600, color: isDarkMode ? AppColor.textPrimary : Colors.black87)),
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
            decoration: BoxDecoration(color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade100, shape: BoxShape.circle),
            child: Icon(icon, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade500, size: width * 0.04),
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: width * 0.033, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700)),
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
            child: Icon(Icons.car_repair_rounded, size: width * 0.08, color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade400),
          ),
        ),
        SizedBox(height: width * 0.015),
        Text(label, style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.w600, color: isDarkMode ? AppColor.textPrimary : Colors.black87)),
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
            decoration: const BoxDecoration(color: Color(0xFF2FB84C), shape: BoxShape.circle),
            child: Icon(Icons.check_rounded, color: Colors.white, size: width * 0.032),
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: width * 0.033, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700)),
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
          Text(label,
              style: TextStyle(
                  fontSize: width * 0.033, fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600)),
          Text(value,
              style: TextStyle(
                  fontSize: width * 0.033, fontWeight: isBold ? FontWeight.w700 : FontWeight.w600, color: isDarkMode ? AppColor.textPrimary : Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildCameraOnlyBox(bool isDarkMode, double width, double height) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening camera...'), backgroundColor: AppColor.primary, behavior: SnackBarBehavior.floating),
        );
      },
      child: DottedBox(
        isDarkMode: isDarkMode,
        height: height * 0.11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600, size: width * 0.06),
            SizedBox(height: height * 0.006),
            Text('Camera',
                style: TextStyle(fontSize: width * 0.033, fontWeight: FontWeight.w500, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkProgressItem(int number, String title, bool isDarkMode, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$number. $title',
            style: TextStyle(fontSize: width * 0.036, fontWeight: FontWeight.w600, color: isDarkMode ? AppColor.textPrimary : Colors.black87)),
        SizedBox(height: height * 0.01),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            height: height * 0.16,
            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
            child: Icon(Icons.car_repair_rounded, size: width * 0.1, color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade400),
          ),
        ),
        SizedBox(height: height * 0.012),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening camera...'), backgroundColor: AppColor.primary, behavior: SnackBarBehavior.floating),
                  );
                },
                child: DottedBox(
                  isDarkMode: isDarkMode,
                  height: height * 0.09,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600, size: width * 0.055),
                      SizedBox(height: height * 0.005),
                      Text('Camera',
                          style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.w500, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600)),
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
                    const SnackBar(content: Text('Uploading image...'), backgroundColor: AppColor.primary, behavior: SnackBarBehavior.floating),
                  );
                },
                child: DottedBox(
                  isDarkMode: isDarkMode,
                  height: height * 0.09,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_upload_outlined, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600, size: width * 0.055),
                      SizedBox(height: height * 0.005),
                      Text('Upload image',
                          style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.w500, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.012),
        SizedBox(
          width: double.infinity,
          height: height * 0.052,
          child: OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Submitted successfully!'), backgroundColor: AppColor.primary, behavior: SnackBarBehavior.floating),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF2FB84C), width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text('Submit', style: TextStyle(fontSize: width * 0.035, fontWeight: FontWeight.w600, color: const Color(0xFF2FB84C))),
          ),
        ),
      ],
    );
  }
}

// ── Shared small widgets ────────────────────────────────────────────────

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
        Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}

// Dashed-border container used for camera/upload placeholders
class DottedBox extends StatelessWidget {
  final Widget child;
  final double height;
  final bool isDarkMode;

  const DottedBox({super.key, required this.child, required this.height, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(isDarkMode: isDarkMode),
      child: Container(width: double.infinity, height: height, alignment: Alignment.center, child: child),
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

    final RRect rrect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(radius));
    final Path path = Path()..addRRect(rrect);
    final Path dashedPath = Path();

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = distance + dashWidth;
        dashedPath.addPath(metric.extractPath(distance, next.clamp(0, metric.length)), Offset.zero);
        distance = next + dashSpace;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── OTP bottom sheet: Reject job (4-digit, from old ScreenOne) ──────────

class _RejectOtpBottomSheet extends StatefulWidget {
  final VoidCallback onConfirmed;
  const _RejectOtpBottomSheet({required this.onConfirmed});

  @override
  State<_RejectOtpBottomSheet> createState() => _RejectOtpBottomSheetState();
}

class _RejectOtpBottomSheetState extends State<_RejectOtpBottomSheet> {
  static const int _len = 4;
  final List<TextEditingController> _controllers = List.generate(_len, (_) => TextEditingController());
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
        padding: EdgeInsets.fromLTRB(width * 0.06, height * 0.025, width * 0.06, height * 0.04),
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
                  color: isDarkMode ? Colors.white.withOpacity(0.2) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text('Enter OTP', style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w700, color: isDarkMode ? AppColor.textPrimary : Colors.black87)),
            SizedBox(height: height * 0.008),
            Text('Enter the 4-digit OTP to confirm return',
                style: TextStyle(fontSize: width * 0.033, color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600)),
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
                    style: TextStyle(fontSize: width * 0.055, fontWeight: FontWeight.w700, color: isDarkMode ? AppColor.textPrimary : Colors.black87),
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: isDarkMode ? Colors.white.withOpacity(0.15) : Colors.grey.shade300, width: 1.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF2FB84C), width: 1.8),
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
                      const SnackBar(content: Text('Please enter the full OTP'), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating),
                    );
                    return;
                  }
                  widget.onConfirmed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: Text('Reject Job', style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── OTP bottom sheet: Complete job (6-digit + swipe, from old ScreenFour) ─

class _CompleteOtpBottomSheet extends StatefulWidget {
  final VoidCallback onConfirmed;
  const _CompleteOtpBottomSheet({required this.onConfirmed});

  @override
  State<_CompleteOtpBottomSheet> createState() => _CompleteOtpBottomSheetState();
}

class _CompleteOtpBottomSheetState extends State<_CompleteOtpBottomSheet> {
  static const int otpLength = 6;
  final List<TextEditingController> _controllers = List.generate(otpLength, (_) => TextEditingController());
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

  void _complete() {
    if (_isCompleting) return;
    if (!_isOtpComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit OTP'), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating),
      );
      setState(() => _dragExtent = 0);
      return;
    }
    _isCompleting = true;
    widget.onConfirmed();
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
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        ),
        padding: EdgeInsets.fromLTRB(width * 0.06, height * 0.025, width * 0.06, height * 0.035),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: width * 0.1,
                height: 4,
                margin: EdgeInsets.only(bottom: height * 0.02),
                decoration: BoxDecoration(color: isDarkMode ? Colors.white.withOpacity(0.2) : Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Text('Enter OTP', style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w700, color: isDarkMode ? AppColor.textPrimary : Colors.black87)),
            SizedBox(height: height * 0.02),
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
                    style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w700, color: isDarkMode ? AppColor.textPrimary : Colors.black87),
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: isDarkMode ? Colors.white.withOpacity(0.15) : Colors.grey.shade300, width: 1.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2FB84C), width: 1.5),
                      ),
                    ),
                    onChanged: (value) => _onDigitChanged(index, value),
                  ),
                );
              }),
            ),
            SizedBox(height: height * 0.035),
            _buildSwipeSlider(isDarkMode, width, height),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeSlider(bool isDarkMode, double width, double height) {
    final double sliderHeight = height * 0.065;
    final double handleSize = sliderHeight - 8;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double effectiveMaxDrag = constraints.maxWidth - handleSize - 8;
        return Container(
          width: double.infinity,
          height: sliderHeight,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF2FB84C), Color(0xFF1E8E3E)]),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [BoxShadow(color: const Color(0xFF2FB84C).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: Text('Swipe to Start',
                    style: TextStyle(fontSize: width * 0.038, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5)),
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
                      _complete();
                    } else {
                      setState(() => _dragExtent = 0);
                    }
                  },
                  child: Container(
                    width: handleSize,
                    height: handleSize,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.keyboard_double_arrow_right_rounded, color: Color(0xFF2FB84C)),
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
