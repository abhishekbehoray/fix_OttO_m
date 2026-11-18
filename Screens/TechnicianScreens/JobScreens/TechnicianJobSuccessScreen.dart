// TechnicianJobSuccessScreen.dart
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/MainWrapper/TechnicianMainWrapper.dart';
import 'package:flutter/material.dart';

class TechnicianJobSuccessScreen extends StatefulWidget {
  const TechnicianJobSuccessScreen({super.key});

  @override
  State<TechnicianJobSuccessScreen> createState() => _TechnicianJobSuccessScreenState();
}

class _TechnicianJobSuccessScreenState extends State<TechnicianJobSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  static const Color _green = Color(0xFF2FB84C);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();

    // Auto navigate to home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const TechnicianMainWrapper(initialIndex: 0),
          ),
              (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: _green,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── Success Icon (outlined circle + check) ──
                        SizedBox(
                          width: width * 0.28,
                          height: width * 0.28,
                          child: CustomPaint(
                            painter: _CheckCirclePainter(),
                          ),
                        ),

                        SizedBox(height: height * 0.035),

                        // ── Title ──
                        Text(
                          'Job Successfully Completed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: height * 0.015),

                        // ── Subtitle ──
                        Text(
                          'Great work! The job has been completed successfully and all tasks are marked done.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Draws a white circular ring with a checkmark, with a gap in the ring
// at the top-right where the checkmark's upper stroke passes through
// (matches the reference icon style).
class _CheckCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2 * 0.82;

    final Paint ringPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round;

    // Ring with a gap from ~5 o'clock to ~1 o'clock (where checkmark exits)
    final Rect ringRect = Rect.fromCircle(center: center, radius: radius);
    const double startAngle = 0.35 * 3.14159; // radians
    const double sweepAngle = 2 * 3.14159 - 0.9;
    canvas.drawArc(ringRect, startAngle, sweepAngle, false, ringPaint);

    // Checkmark
    final Paint checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Path checkPath = Path();
    final Offset p1 = Offset(size.width * 0.28, size.height * 0.52);
    final Offset p2 = Offset(size.width * 0.44, size.height * 0.68);
    final Offset p3 = Offset(size.width * 0.76, size.height * 0.34);

    checkPath.moveTo(p1.dx, p1.dy);
    checkPath.lineTo(p2.dx, p2.dy);
    checkPath.lineTo(p3.dx, p3.dy);

    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}