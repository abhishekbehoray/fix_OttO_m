import 'package:fixottobuddy_techni/Screens/TechnicianScreens/MainWrapper/TechnicianMainWrapper.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class ProfileUnderReviewScreen extends StatelessWidget {
  const ProfileUnderReviewScreen({super.key});

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
                horizontal: width * 0.08,
                vertical: height * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.02),

                  // Decorative illustration
                  SizedBox(
                    height: height * 0.24,
                    width: double.infinity,
                    child: _FloatingCloudsIllustration(
                      width: width,
                      illustrationHeight: height * 0.24,
                      isDarkMode: isDarkMode,
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  // Vertical checklist - Centered
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTimelineItem(
                        icon: Icons.check,
                        title: 'Registration Successful',
                        description: null,
                        isDone: true,
                        isLast: false,
                        lineDone: true,
                        isDarkMode: isDarkMode,
                        width: width,
                        height: height,
                      ),
                      _buildTimelineItem(
                        icon: Icons.check,
                        title: 'Profile Completed',
                        description: null,
                        isDone: true,
                        isLast: false,
                        lineDone: true,
                        isDarkMode: isDarkMode,
                        width: width,
                        height: height,
                      ),
                      _buildTimelineItem(
                        icon: null,
                        title: 'Your profile under review',
                        description: 'We are verifying your profile. This may take up to 24 hours.',
                        isDone: false,
                        isLast: true,
                        lineDone: false,
                        isDarkMode: isDarkMode,
                        width: width,
                        height: height,
                        trailingLink: GestureDetector(
                          onTap: () {
                            // Raise a ticket
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              'Raise a ticket',
                              style: TextStyle(
                                fontSize: width * 0.033,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFE07A1F),
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(0xFFE07A1F),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.04),

                  // Go to dashboard
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TechnicianMainWrapper(initialIndex: 0),
                          ),
                          (route) => false,
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
                        'Go to dashboard',
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

  Widget _buildTimelineItem({
    required IconData? icon,
    required String title,
    required String? description,
    required bool isDone,
    required bool isLast,
    required bool lineDone,
    required bool isDarkMode,
    required double width,
    required double height,
    Widget? trailingLink,
  }) {
    final Color circleColor = isDone
        ? const Color(0xFF3CB878)
        : (isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: width * 0.08,
                height: width * 0.08,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: icon != null
                    ? Icon(icon, color: Colors.white, size: width * 0.045)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3,
                    color: lineDone
                        ? const Color(0xFF3CB878)
                        : (isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300),
                  ),
                ),
            ],
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: height * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  if (description != null) ...[
                    SizedBox(height: height * 0.006),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: width * 0.032,
                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                  if (trailingLink != null) trailingLink,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated decorative header: soft clouds drift continuously left-to-right
/// at slightly different speeds/heights for a light parallax feel, plus a
/// couple of static sparkles and a bold "DATA" wordmark. Colors adapt to
/// dark mode so the wordmark and clouds stay visible on the dark gradient.
class _FloatingCloudsIllustration extends StatefulWidget {
  final double width;
  final double illustrationHeight;
  final bool isDarkMode;

  const _FloatingCloudsIllustration({
    required this.width,
    required this.illustrationHeight,
    required this.isDarkMode,
  });

  @override
  State<_FloatingCloudsIllustration> createState() => _FloatingCloudsIllustrationState();
}

class _FloatingCloudsIllustrationState extends State<_FloatingCloudsIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.width;
    final double h = widget.illustrationHeight;
    final bool isDarkMode = widget.isDarkMode;

    final Color cloudColor = isDarkMode ? Colors.white.withOpacity(0.14) : const Color(0xFFFCE8CE);
    final Color starColor = isDarkMode ? Colors.white.withOpacity(0.35) : const Color(0xFFF3C969);
    final Color lineColor = isDarkMode ? Colors.white.withOpacity(0.15) : Colors.grey.shade300;

    return ClipRect(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              _driftingCloud(
                progress: _controller.value,
                phase: 0.0,
                top: h * 0.05,
                size: width * 0.09,
                width: width,
                color: cloudColor,
              ),
              _driftingCloud(
                progress: _controller.value,
                phase: 0.4,
                top: h * 0.22,
                size: width * 0.13,
                width: width,
                color: cloudColor,
              ),
              _driftingCloud(
                progress: _controller.value,
                phase: 0.7,
                top: h * 0.0,
                size: width * 0.07,
                width: width,
                color: cloudColor,
              ),
              Positioned(
                top: h * 0.12,
                right: width * 0.28,
                child: Icon(Icons.star_rounded, size: width * 0.03, color: starColor),
              ),
              Positioned(
                bottom: h * 0.22,
                left: width * 0.06,
                child: Icon(Icons.star_rounded, size: width * 0.025, color: starColor),
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'D',
                        style: TextStyle(
                          fontSize: width * 0.14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: const Color(0xFFF5A623),
                        ),
                      ),
                      TextSpan(
                        text: 'ATA',
                        style: TextStyle(
                          fontSize: width * 0.14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: h * 0.03,
                child: Container(
                  width: width * 0.7,
                  height: 1,
                  color: lineColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// A cloud that drifts from just off-screen left to just off-screen right,
  /// then loops. [phase] offsets each cloud's position in the loop so they
  /// don't all move in lockstep.
  Widget _driftingCloud({
    required double progress,
    required double phase,
    required double top,
    required double size,
    required double width,
    required Color color,
  }) {
    final double t = (progress + phase) % 1.0;
    final double travel = width + size * 2;
    final double left = -size + t * travel;
    return Positioned(
      top: top,
      left: left,
      child: Icon(Icons.cloud_rounded, size: size, color: color),
    );
  }
}