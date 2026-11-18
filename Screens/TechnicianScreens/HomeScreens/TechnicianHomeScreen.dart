import 'package:fixottobuddy_techni/Screens/TechnicianScreens/HomeScreens/TechnicianNotificationScreen.dart';
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/MainWrapper/TechnicianMainWrapper.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class TechnicianHomeScreen extends StatefulWidget {
  const TechnicianHomeScreen({super.key});

  @override
  State<TechnicianHomeScreen> createState() => _TechnicianHomeScreenState();
}

class _TechnicianHomeScreenState extends State<TechnicianHomeScreen> {
  bool _isOnline = true;

  final List<_PromoBanner> _promoBanners = const [
    _PromoBanner(
      title: 'TOP ASSIST',
      subtitle: 'ROAD SIDE ASSISTANCE PROGRAM',
      colors: [Color(0xFF1B3A7A), Color(0xFF3E6FD9)],
      icon: Icons.local_shipping_rounded,
    ),
    _PromoBanner(
      title: 'REFER & EARN',
      subtitle: 'INVITE TECHNICIANS, GET REWARDS',
      colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
      icon: Icons.smartphone_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final double topInset = MediaQuery.of(context).padding.top;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF15151F) : const Color(0xFFF7F7F9),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ── Green Header WITH Banner inside ──
            Container(
              width: width,
              padding: EdgeInsets.fromLTRB(
                width * 0.05,
                topInset + height * 0.015,
                width * 0.05,
                height * 0.02,
              ),
              decoration: const BoxDecoration(
                color: AppColor.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Location',
                                  style: TextStyle(
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white.withOpacity(0.9),
                                  size: width * 0.045,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.002),
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded, color: Colors.white, size: width * 0.04),
                                SizedBox(width: width * 0.01),
                                Expanded(
                                  child: Text(
                                    'Moti Nagar Rd, DLE Industrial Area...',
                                    style: TextStyle(
                                      fontSize: width * 0.037,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Notification
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TechnicianNotificationScreen(),
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: EdgeInsets.all(width * 0.026),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.notifications_none_rounded,
                                color: AppColor.primary,
                                size: width * 0.055,
                              ),
                            ),
                            Positioned(
                              top: -2,
                              right: -2,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: width * 0.045,
                                  minHeight: width * 0.045,
                                ),
                                child: Center(
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: width * 0.026,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.012),

                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                                child: Icon(
                                  Icons.search_rounded,
                                  color: Colors.grey.shade400,
                                  size: width * 0.05,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: width * 0.035,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: width * 0.035,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: height * 0.016,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Icon(
                                  Icons.tune_rounded,
                                  color: Colors.grey.shade400,
                                  size: width * 0.05,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.025),
                      GestureDetector(
                        onTap: () => setState(() => _isOnline = !_isOnline),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.028, vertical: height * 0.014),
                          decoration: BoxDecoration(
                            color: _isOnline ? AppColor.primary : Colors.grey.shade400,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            _isOnline ? 'ON' : 'OFF',
                            style: TextStyle(
                              fontSize: width * 0.026,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ── BANNER INSIDE HEADER ──
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: height * 0.19,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Image
                          Image.asset(
                            ImageAssets.homeBanner,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: AppColor.primary,
                              child: const Center(
                                child: Text(
                                  'Hassle Free Process',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Text at bottom center
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Hassle Free Process',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'For Every Technician',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Body ──
            Padding(
              padding: EdgeInsets.fromLTRB(
                width * 0.05,
                height * 0.02,
                width * 0.05,
                height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dashboard Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: width * 0.048,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list_rounded,
                              color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                              size: width * 0.04,
                            ),
                            SizedBox(width: width * 0.005),
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: width * 0.032,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.018),

                  // Stats - Clickable
                  GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const TechnicianMainWrapper(initialIndex: 1)),
                          (route) => false,
                    ),
                    child: _buildStatRow(
                      'Total Earnings',
                      '₹11,250',
                      isDarkMode,
                      width,
                      height,
                      trailing: _buildCoinIcon(width),
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const TechnicianMainWrapper(initialIndex: 1)),
                          (route) => false,
                    ),
                    child: _buildStatRow(
                      'Total Jobs',
                      '45',
                      isDarkMode,
                      width,
                      height,
                      trailing: Image.asset(
                        ImageAssets.statsImage,
                        width: width * 0.12,
                        height: width * 0.12,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const TechnicianMainWrapper(initialIndex: 1)),
                          (route) => false,
                    ),
                    child: _buildStatRow(
                      "Today's Jobs",
                      '03',
                      isDarkMode,
                      width,
                      height,
                      trailing: Image.asset(
                        ImageAssets.statsImage,
                        width: width * 0.12,
                        height: width * 0.12,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Promo Banners
                  SizedBox(
                    height: height * 0.12,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _promoBanners.length,
                      separatorBuilder: (_, __) => SizedBox(width: width * 0.03),
                      itemBuilder: (context, index) {
                        final banner = _promoBanners[index];
                        return _buildPromoBanner(banner, width, height);
                      },
                    ),
                  ),

                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
      String title,
      String value,
      bool isDarkMode,
      double width,
      double height, {
        required Widget trailing,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.045, vertical: height * 0.018),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: width * 0.037,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? AppColor.textSecondary : Colors.black87,
                ),
              ),
              SizedBox(height: height * 0.006),
              Text(
                value,
                style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w800,
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildCoinIcon(double width) {
    return Container(
      width: width * 0.11,
      height: width * 0.11,
      decoration: BoxDecoration(
        color: AppColor.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.currency_rupee_rounded, color: AppColor.primary, size: width * 0.06),
    );
  }

  Widget _buildPromoBanner(_PromoBanner banner, double width, double height) {
    return Container(
      width: width * 0.78,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: banner.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -width * 0.02,
            bottom: -height * 0.01,
            child: Icon(banner.icon, color: Colors.white.withOpacity(0.15), size: width * 0.22),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  banner.title,
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  banner.subtitle,
                  style: TextStyle(
                    fontSize: width * 0.028,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
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

class _PromoBanner {
  final String title;
  final String subtitle;
  final List<Color> colors;
  final IconData icon;

  const _PromoBanner({
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.icon,
  });
}