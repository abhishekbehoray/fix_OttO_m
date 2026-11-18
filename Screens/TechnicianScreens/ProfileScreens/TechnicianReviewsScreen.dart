// TechnicianReviewsScreen.dart
import 'dart:math' as math;

import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class TechnicianReviewsScreen extends StatefulWidget {
  const TechnicianReviewsScreen({super.key});

  @override
  State<TechnicianReviewsScreen> createState() => _TechnicianReviewsScreenState();
}

class _TechnicianReviewsScreenState extends State<TechnicianReviewsScreen> {
  // Sample review data
  final List<ReviewData> _reviews = [
    ReviewData(
      name: 'John Doe',
      rating: 5,
      comment: 'Excellent service! Very professional and quick.',
      date: '2 days ago',
    ),
    ReviewData(
      name: 'Sarah Smith',
      rating: 4,
      comment: 'Good work, but took a bit longer than expected.',
      date: '5 days ago',
    ),
    ReviewData(
      name: 'Mike Johnson',
      rating: 5,
      comment: 'Highly recommend! Fixed my issue in no time.',
      date: '1 week ago',
    ),
    ReviewData(
      name: 'Emily Brown',
      rating: 3,
      comment: 'Average service. Could have been better.',
      date: '2 weeks ago',
    ),
    ReviewData(
      name: 'David Wilson',
      rating: 5,
      comment: 'Amazing technician! Very knowledgeable.',
      date: '3 weeks ago',
    ),
  ];

  // Rating breakdown shown in the summary chart. In a real implementation
  // this (and the average / total below) would come from the backend.
  static const Map<int, int> _starCounts = {
    5: 48,
    4: 22,
    3: 16,
    2: 8,
    1: 18,
  };

  static const double _averageRating = 3.5;
  static const int _totalRatings = 210;

  static const Map<int, Color> _starColors = {
    5: Color(0xFF29B6F6),
    4: Color(0xFF33A852),
    3: Color(0xFFF6D816),
    2: Color(0xFFFFA000),
    1: Color(0xFFFF5722),
  };

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final int totalBreakdown = _starCounts.values.fold(0, (a, b) => a + b);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: isDarkMode ? AppColor.getOnboardingGradient(brightness) : null,
          color: isDarkMode ? null : Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(
                  width * 0.04,
                  height * 0.02,
                  width * 0.04,
                  height * 0.015,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
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
                          'Reviews',
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
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.015),

                      // "Your Average Rating" + gauge
                      Center(
                        child: Text(
                          'Your Average Rating',
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Center(
                        child: RatingGauge(
                          rating: _averageRating,
                          maxRating: 5,
                          totalRatings: _totalRatings,
                          size: width * 0.55,
                          trackColor: isDarkMode ? Colors.white.withOpacity(0.12) : Colors.grey.shade200,
                          progressColor: const Color(0xFF33A852),
                          textColor: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          subTextColor: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        ),
                      ),

                      SizedBox(height: height * 0.035),

                      // All Reviews Section
                      Text(
                        'All Reviews',
                        style: TextStyle(
                          fontSize: width * 0.048,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        ),
                      ),
                      SizedBox(height: height * 0.018),

                      for (int star = 5; star >= 1; star--) ...[
                        _buildRatingBarRow(
                          star: star,
                          count: _starCounts[star] ?? 0,
                          total: totalBreakdown,
                          color: _starColors[star]!,
                          isDarkMode: isDarkMode,
                          width: width,
                          height: height,
                        ),
                        SizedBox(height: height * 0.018),
                      ],

                      SizedBox(height: height * 0.015),

                      // Individual review cards
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _reviews.length,
                        itemBuilder: (context, index) {
                          return _buildReviewItem(
                            _reviews[index],
                            isDarkMode,
                            width,
                            height,
                            index == _reviews.length - 1,
                          );
                        },
                      ),

                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBarRow({
    required int star,
    required int count,
    required int total,
    required Color color,
    required bool isDarkMode,
    required double width,
    required double height,
  }) {
    final double percentage = total > 0 ? count / total : 0;
    final int percentInt = (percentage * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$star star',
              style: TextStyle(
                fontSize: width * 0.036,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700,
              ),
            ),
            const Spacer(),
            Text(
              '$count reviews ($percentInt%)',
              style: TextStyle(
                fontSize: width * 0.034,
                color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade600,
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.008),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: height * 0.011,
            backgroundColor: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(
      ReviewData review,
      bool isDarkMode,
      double width,
      double height,
      bool isLast,
      ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.015),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: width * 0.1,
                height: width * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    review.name.isNotEmpty ? review.name[0].toUpperCase() : 'U',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * 0.035),

              // Review Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                      ),
                    ),
                    SizedBox(height: height * 0.003),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review.rating ? Icons.star_rounded : Icons.star_outline_rounded,
                            color: Colors.amber,
                            size: width * 0.035,
                          );
                        }),
                        SizedBox(width: width * 0.025),
                        Text(
                          review.date,
                          style: TextStyle(
                            fontSize: width * 0.028,
                            color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      review.comment,
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
            thickness: 0.6,
            height: 0,
          ),
      ],
    );
  }
}

/// A horseshoe-style radial gauge used to display the average rating,
/// e.g. "3.5/5" with "210 Ratings" underneath, matching the reviews screen.
class RatingGauge extends StatelessWidget {
  final double rating;
  final double maxRating;
  final int totalRatings;
  final double size;
  final Color trackColor;
  final Color progressColor;
  final Color textColor;
  final Color subTextColor;

  const RatingGauge({
    super.key,
    required this.rating,
    required this.maxRating,
    required this.totalRatings,
    required this.size,
    required this.trackColor,
    required this.progressColor,
    required this.textColor,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (rating / maxRating).clamp(0, 1);

    return SizedBox(
      width: size,
      height: size * 0.68,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size * 0.68),
            painter: _GaugePainter(
              percentage: percentage,
              trackColor: trackColor,
              progressColor: progressColor,
              strokeWidth: size * 0.075,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size * 0.12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${rating.toStringAsFixed(1)}/${maxRating.toInt()}',
                  style: TextStyle(
                    fontSize: size * 0.16,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
                SizedBox(height: size * 0.02),
                Text(
                  '$totalRatings Ratings',
                  style: TextStyle(
                    fontSize: size * 0.075,
                    fontWeight: FontWeight.w500,
                    color: subTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double percentage; // 0..1
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  _GaugePainter({
    required this.percentage,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  // Horseshoe gauge: slightly more than a semicircle, opening at the bottom.
  static const double _startAngle = 3.6216; // ~207.5°
  static const double _sweepAngle = 4.7998; // ~275°

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = (math.min(size.width, size.height * 1.6) - strokeWidth) / 2;
    final Offset center = Offset(size.width / 2, radius + strokeWidth / 2);

    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, _startAngle, _sweepAngle, false, trackPaint);
    canvas.drawArc(rect, _startAngle, _sweepAngle * percentage, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      oldDelegate.percentage != percentage ||
          oldDelegate.trackColor != trackColor ||
          oldDelegate.progressColor != progressColor ||
          oldDelegate.strokeWidth != strokeWidth;
}

// Review Data Model
class ReviewData {
  final String name;
  final int rating;
  final String comment;
  final String date;

  ReviewData({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });
}