import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/HomeScreens/OttoBuddyHomeScreen.dart';
import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/JobScreens/OttoBuddyJobsScreen.dart';
import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/ProfileScreens/OttoBuddyProfileScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class OttoBuddyMainWrapper extends StatefulWidget {
  final int initialIndex;
  const OttoBuddyMainWrapper({super.key, this.initialIndex = 0});

  @override
  State<OttoBuddyMainWrapper> createState() => _OttoBuddyMainWrapperState();
}

class _OttoBuddyMainWrapperState extends State<OttoBuddyMainWrapper> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const OttoBuddyHomeScreen(),
    const OttoBuddyJobsScreen(),
    const OttoBuddyProfileScreen(),
  ];

  final List<String> _titles = ['Home', 'Jobs', 'Profile'];

  final List<IconData> _outlineIcons = [
    Icons.home_outlined,
    Icons.work_outline_rounded,
    Icons.person_outline_rounded,
  ];

  final List<IconData> _filledIcons = [
    Icons.home_rounded,
    Icons.work_rounded,
    Icons.person_rounded,
  ];

  // Index of the tab shown as the floating center button (matches
  // MainWrapper's "Shop" treatment).
  static const int _centerIndex = 1;

  static const Color _accentGreen = Color(0xFF2FA84F);

  // Method to navigate to a specific tab from anywhere
  void navigateToTab(int index) {
    if (index >= 0 && index < _screens.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final double bottomInset = MediaQuery.of(context).padding.bottom;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final Color barColor = isDarkMode ? const Color(0xFF1E1E2E) : Colors.white;

    const double extraBottomPadding = 8.0;

    final double btnSize = width * 0.15;
    final double valleyDepth = btnSize * 0.35;
    final double barHeight = height * 0.075 + bottomInset + extraBottomPadding;
    final double navTotalHeight = barHeight + valleyDepth;

    return Scaffold(
      body: Stack(
        children: [
          // Screen content
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: barHeight + 10),
              child: _screens[_selectedIndex],
            ),
          ),

          // Curved nav bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              painter: _UCurvePainter(
                color: barColor,
                valleyDepth: valleyDepth,
                shadowColor: Colors.black.withOpacity(isDarkMode ? 0.28 : 0.10),
              ),
              child: SizedBox(
                height: navTotalHeight + extraBottomPadding,
                child: Column(
                  children: [
                    SizedBox(height: valleyDepth),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: bottomInset + extraBottomPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavItem(0, width, height, isDarkMode),
                            SizedBox(width: btnSize * 1.1),
                            _buildNavItem(2, width, height, isDarkMode),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Jobs floating center button
          Positioned(
            left: (width - btnSize) / 2,
            bottom: barHeight - btnSize / 2 + extraBottomPadding,
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = _centerIndex),
              child: Container(
                width: btnSize,
                height: btnSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _accentGreen,
                  boxShadow: [
                    BoxShadow(
                      color: _accentGreen.withOpacity(0.45),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  _selectedIndex == _centerIndex
                      ? Icons.work_rounded
                      : Icons.work_outline_rounded,
                  color: Colors.white,
                  size: btnSize * 0.52,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, double width, double height, bool isDarkMode) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _selectedIndex = index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? _filledIcons[index] : _outlineIcons[index],
              size: width * 0.078,
              color: isSelected
                  ? _accentGreen
                  : isDarkMode
                  ? AppColor.textSecondary
                  : Colors.grey.shade400,
            ),
            SizedBox(height: height * 0.003),
            Text(
              _titles[index],
              style: TextStyle(
                fontSize: width * 0.028,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? _accentGreen
                    : isDarkMode
                    ? AppColor.textSecondary
                    : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UCurvePainter extends CustomPainter {
  final Color color;
  final double valleyDepth;
  final Color shadowColor;

  const _UCurvePainter({
    required this.color,
    required this.valleyDepth,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);
    canvas.drawShadow(path.shift(const Offset(0, -2)), shadowColor, 10, false);
    canvas.drawPath(path, Paint()..color = color);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black.withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  Path _buildPath(Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;

    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(cx, valleyDepth * 2.0, w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _UCurvePainter old) =>
      old.color != color ||
          old.valleyDepth != valleyDepth ||
          old.shadowColor != shadowColor;
}