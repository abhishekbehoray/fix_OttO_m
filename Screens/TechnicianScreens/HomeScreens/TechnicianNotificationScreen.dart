// TechnicianNotificationScreen.dart
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TechnicianNotificationScreen extends StatefulWidget {
  const TechnicianNotificationScreen({super.key});

  @override
  State<TechnicianNotificationScreen> createState() => _TechnicianNotificationScreenState();
}

class _TechnicianNotificationScreenState extends State<TechnicianNotificationScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Job Assignment',
      'message': 'You have been assigned a new job #BK1023 at Car Service Center',
      'time': '2 min ago',
      'icon': Icons.work_rounded,
      'color': const Color(0xFF2FB84C),
      'isRead': false,
      'type': 'Job',
    },
    {
      'title': 'Payment Received',
      'message': 'You have received ₹1,200 for job #BK1020 from Rahul Sharma',
      'time': '15 min ago',
      'icon': Icons.payments_rounded,
      'color': const Color(0xFF2196F3),
      'isRead': false,
      'type': 'Payment',
    },
    {
      'title': 'Job Completed',
      'message': 'Job #BK1018 has been marked as completed by the customer',
      'time': '1 hour ago',
      'icon': Icons.check_circle_rounded,
      'color': const Color(0xFFFFA500),
      'isRead': false,
      'type': 'Job',
    },
    {
      'title': 'New Message',
      'message': 'Rahul Sharma sent you a message regarding job #BK1017',
      'time': '3 hours ago',
      'icon': Icons.message_rounded,
      'color': const Color(0xFF9C27B0),
      'isRead': true,
      'type': 'Message',
    },
    {
      'title': 'Wallet Updated',
      'message': 'Your wallet has been credited with ₹500 as bonus reward',
      'time': '5 hours ago',
      'icon': Icons.account_balance_wallet_rounded,
      'color': const Color(0xFF4CAF50),
      'isRead': true,
      'type': 'Wallet',
    },
    {
      'title': 'Job Cancelled',
      'message': 'Job #BK1015 has been cancelled by the customer',
      'time': '1 day ago',
      'icon': Icons.cancel_rounded,
      'color': const Color(0xFFE74C3C),
      'isRead': true,
      'type': 'Job',
    },
    {
      'title': 'Review Received',
      'message': 'You received a 5-star review from Priya Patel',
      'time': '2 days ago',
      'icon': Icons.star_rounded,
      'color': const Color(0xFFFFD700),
      'isRead': true,
      'type': 'Review',
    },
    {
      'title': 'Profile Updated',
      'message': 'Your profile information has been successfully updated',
      'time': '3 days ago',
      'icon': Icons.person_rounded,
      'color': const Color(0xFF607D8B),
      'isRead': true,
      'type': 'Profile',
    },
  ];

  List<Map<String, dynamic>> get _filteredNotifications {
    if (_selectedFilter == 'All') {
      return _notifications;
    }
    return _notifications.where((n) => n['type'] == _selectedFilter).toList();
  }

  int get _unreadCount {
    return _notifications.where((n) => n['isRead'] == false).length;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ── Header ──
              Padding(
                padding: EdgeInsets.fromLTRB(
                  width * 0.05,
                  height * 0.02,
                  width * 0.05,
                  height * 0.015,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.025),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.08)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.12)
                                : Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: isDarkMode ? Colors.white : Colors.black87,
                          size: width * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        ),
                      ),
                    ),
                    if (_unreadCount > 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$_unreadCount new',
                          style: TextStyle(
                            fontSize: width * 0.025,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    SizedBox(width: width * 0.02),
                    GestureDetector(
                      onTap: () {
                        // Mark all as read
                        setState(() {
                          for (var notification in _notifications) {
                            notification['isRead'] = true;
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('All notifications marked as read'),
                            backgroundColor: AppColor.primary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.done_all_rounded,
                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                        size: width * 0.055,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                height: 1,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.08)
                    : Colors.grey.shade200,
              ),

              // ── Filter Tabs ──
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All', isDarkMode, width),
                      SizedBox(width: width * 0.02),
                      _buildFilterChip('Job', isDarkMode, width),
                      SizedBox(width: width * 0.02),
                      _buildFilterChip('Payment', isDarkMode, width),
                      SizedBox(width: width * 0.02),
                      _buildFilterChip('Message', isDarkMode, width),
                      SizedBox(width: width * 0.02),
                      _buildFilterChip('Wallet', isDarkMode, width),
                      SizedBox(width: width * 0.02),
                      _buildFilterChip('Review', isDarkMode, width),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.01),

              // ── Notifications List ──
              Expanded(
                child: _filteredNotifications.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off_rounded,
                        size: width * 0.15,
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.2)
                            : Colors.grey.shade300,
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'No notifications',
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? AppColor.textSecondary
                              : Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        'You\'re all caught up!',
                        style: TextStyle(
                          fontSize: width * 0.032,
                          color: isDarkMode
                              ? AppColor.textTertiary
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  itemCount: _filteredNotifications.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.06)
                        : Colors.grey.shade100,
                  ),
                  itemBuilder: (_, i) => _buildNotificationItem(
                    _filteredNotifications[i],
                    isDarkMode,
                    width,
                    height,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isDarkMode, double width) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: width * 0.025,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primary
              : isDarkMode
              ? Colors.white.withOpacity(0.06)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColor.primary
                : isDarkMode
                ? Colors.white.withOpacity(0.08)
                : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: width * 0.03,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : (isDarkMode ? Colors.white54 : Colors.grey.shade600),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
      Map<String, dynamic> notification,
      bool isDarkMode,
      double width,
      double height,
      ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          notification['isRead'] = true;
        });
        // Navigate to respective screen based on notification type
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.015),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon ──
            Container(
              width: width * 0.12,
              height: width * 0.12,
              decoration: BoxDecoration(
                color: (notification['color'] as Color).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                notification['icon'],
                color: notification['color'],
                size: width * 0.055,
              ),
            ),
            SizedBox(width: width * 0.035),

            // ── Content ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification['title'],
                          style: TextStyle(
                            fontSize: width * 0.038,
                            fontWeight: notification['isRead']
                                ? FontWeight.w600
                                : FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                      ),
                      if (!notification['isRead'])
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: height * 0.004),
                  Text(
                    notification['message'],
                    style: TextStyle(
                      fontSize: width * 0.032,
                      color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: height * 0.006),
                  Text(
                    notification['time'],
                    style: TextStyle(
                      fontSize: width * 0.028,
                      color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}