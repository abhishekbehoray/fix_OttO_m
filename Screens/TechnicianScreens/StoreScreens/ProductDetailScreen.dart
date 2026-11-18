import 'package:fixottobuddy_techni/Screens/TechnicianScreens/StoreScreens/TechnicianProductScanScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

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
              padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ──
                  Row(
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
                          'My Vehicle',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.055,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                      ),
                      // ── Scan Icon → TechnicianProductScanScreen ──
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TechnicianProductScanScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: width * 0.1,
                          height: width * 0.1,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.qr_code_scanner_rounded,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            size: width * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),

                  // ── Product Image with overlay text ──
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      height: height * 0.24,
                      color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Center(
                            child: Image.asset(
                              ImageAssets.seatName,
                              width: width * 0.55,
                              fit: BoxFit.contain,
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

                  SizedBox(height: height * 0.02),

                  Text(
                    'Basic Service',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  _buildServiceRow('⏳', '4 Hrs Taken', isDarkMode, width, height),
                  _buildServiceRow('🛡️', '1000 kms or 3 Months Warranty', isDarkMode, width, height),
                  _buildServiceRow('📅', 'Every 5000 kms or 6 Months (Recommended)', isDarkMode, width, height),
                  _buildServiceRow('📍', 'Free Pick-up & Drop', isDarkMode, width, height),

                  SizedBox(height: height * 0.02),
                  Divider(
                    height: 1,
                    color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                  ),
                  SizedBox(height: height * 0.02),

                  Text(
                    'Additional Services',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  _buildIncludedRow('4 Hrs Taken', isDarkMode, width, height),
                  _buildIncludedRow('1000 kms or 3 Months Warranty', isDarkMode, width, height),
                  _buildIncludedRow('Every 5000 kms or 6 Months (Recommended)', isDarkMode, width, height),
                  _buildIncludedRow('Free Pick-up & Drop', isDarkMode, width, height),

                  SizedBox(height: height * 0.02),
                  Divider(
                    height: 1,
                    color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                  ),
                  SizedBox(height: height * 0.02),

                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  _buildFAQItem(context, 'Why should i opt for a Basic Car Service?', isDarkMode, width, height),
                  _buildFAQItem(context, 'Why should i opt for a Basic Car Service?', isDarkMode, width, height),
                  _buildFAQItem(context, 'Why should i opt for a Basic Care Service?', isDarkMode, width, height),
                  _buildFAQItem(context, 'Why should i opt for a Basic Care Service?', isDarkMode, width, height),

                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceRow(String emoji, String text, bool isDarkMode, double width, double height) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.012),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: width * 0.045)),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: width * 0.033,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedRow(String text, bool isDarkMode, double width, double height) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.012),
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

  Widget _buildFAQItem(BuildContext context, String question, bool isDarkMode, double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.01),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.04) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade200,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: TextStyle(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 0, width * 0.04, height * 0.015),
              child: Text(
                'This is the answer to the frequently asked question. It provides detailed information about the service.',
                style: TextStyle(
                  fontSize: width * 0.032,
                  color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
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