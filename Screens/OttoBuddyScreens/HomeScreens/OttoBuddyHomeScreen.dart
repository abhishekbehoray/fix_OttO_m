import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/HomeScreens/OttoBuddyNotificationScreen.dart';
import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/JobScreens/OttoBuddyJobDetailScreen.dart';
import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/WrapperScreens/OttoBuddyMainWrapper.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class OttoBuddyHomeScreen extends StatefulWidget {
  const OttoBuddyHomeScreen({super.key});

  @override
  State<OttoBuddyHomeScreen> createState() => _OttoBuddyHomeScreenState();
}

class _OttoBuddyHomeScreenState extends State<OttoBuddyHomeScreen> {
  String _selectedDays = '15 Days';
  DateTime? _fromDate;
  DateTime? _toDate;

  final List<String> _dayOptions = ['15 Days', '30 Days', '60 Days'];

  void _showFilterPopup() {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.2) : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                // Title
                Text(
                  'Add Filter',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                // Select Days
                Text(
                  'Select Days',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Row(
                  children: _dayOptions.map((day) {
                    final isSelected = _selectedDays == day;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDays = day;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.primary
                              : isDarkMode
                              ? Colors.white.withOpacity(0.06)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primary
                                : isDarkMode
                                ? Colors.white.withOpacity(0.1)
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected
                                ? Colors.white
                                : isDarkMode
                                ? AppColor.textSecondary
                                : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                // From & To
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                          GestureDetector(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: AppColor.primary,
                                        surface: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                                        onSurface: isDarkMode ? AppColor.textPrimary : Colors.black87,
                                      ),
                                      dialogBackgroundColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (date != null) {
                                setState(() {
                                  _fromDate = date;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.03,
                                vertical: MediaQuery.of(context).size.height * 0.015,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.15)
                                      : Colors.grey.shade300,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    color: isDarkMode
                                        ? AppColor.textTertiary
                                        : Colors.grey.shade600,
                                    size: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                  Text(
                                    _fromDate != null
                                        ? '${_fromDate!.day}/${_fromDate!.month}/${_fromDate!.year}'
                                        : 'Select Date',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                      color: _fromDate != null
                                          ? (isDarkMode ? AppColor.textPrimary : Colors.black87)
                                          : (isDarkMode ? AppColor.textTertiary : Colors.grey.shade500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                          GestureDetector(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: AppColor.primary,
                                        surface: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                                        onSurface: isDarkMode ? AppColor.textPrimary : Colors.black87,
                                      ),
                                      dialogBackgroundColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (date != null) {
                                setState(() {
                                  _toDate = date;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.03,
                                vertical: MediaQuery.of(context).size.height * 0.015,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.15)
                                      : Colors.grey.shade300,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    color: isDarkMode
                                        ? AppColor.textTertiary
                                        : Colors.grey.shade600,
                                    size: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                  Text(
                                    _toDate != null
                                        ? '${_toDate!.day}/${_toDate!.month}/${_toDate!.year}'
                                        : 'Select Date',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                      color: _toDate != null
                                          ? (isDarkMode ? AppColor.textPrimary : Colors.black87)
                                          : (isDarkMode ? AppColor.textTertiary : Colors.grey.shade500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                // Apply Filter Button
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.055,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Filter applied successfully!'),
                          backgroundColor: AppColor.primary,
                          behavior: SnackBarBehavior.floating,
                        ),
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
                      'Apply Filter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ],
            ),
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
    final double topInset = MediaQuery.of(context).padding.top;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final List<Map<String, dynamic>> jobs = [
      {
        'name': 'Rajesh Kumar',
        'car': 'Honda City 2020',
        'service': 'Cleaning service',
        'location': 'Sector 62, Noida, Uttar Pradesh 201301',
        'isNew': true,
      },
      {
        'name': 'Rajesh Kumar',
        'car': 'Honda City 2020',
        'service': 'Cleaning service',
        'location': 'Sector 62, Noida, Uttar Pradesh 201301',
        'isNew': true,
      },
      {
        'name': 'Rajesh Kumar',
        'car': 'Honda City 2020',
        'service': 'Cleaning service',
        'location': 'Sector 62, Noida, Uttar Pradesh 201301',
        'isNew': true,
      },
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF15151F) : const Color(0xFFF7F7F9),
      body: Column(
        children: [
          // Green Header: Location + Notification + Search
          Container(
            width: width,
            padding: EdgeInsets.fromLTRB(
              width * 0.05,
              topInset + height * 0.015,
              width * 0.05,
              height * 0.025,
            ),
            decoration: const BoxDecoration(
              color: AppColor.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: Colors.white,
                                size: width * 0.04,
                              ),
                              SizedBox(width: width * 0.01),
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
                          Text(
                            'Moti Nagar Rd, DLE Industrial Area...',
                            style: TextStyle(
                              fontSize: width * 0.037,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Notification Bell with Badge
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OttoBuddyNotificationScreen()),
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

                SizedBox(height: height * 0.02),

                // Search Bar
                Container(
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
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  width * 0.05,
                  height * 0.02,
                  width * 0.05,
                  height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats - Column Layout with Image
                    _buildStatCard(
                      'Total Jobs',
                      '120',
                      isDarkMode,
                      width,
                      height,
                      showFilter: true,
                    ),
                    SizedBox(height: height * 0.015),
                    _buildStatCard(
                      "Today's Jobs",
                      '12',
                      isDarkMode,
                      width,
                      height,
                    ),

                    SizedBox(height: height * 0.025),

                    // Today's Jobs Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Jobs",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const OttoBuddyMainWrapper(initialIndex: 1)),
                                (route) => false,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'View all',
                                style: TextStyle(
                                  fontSize: width * 0.032,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primary,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: AppColor.primary,
                                size: width * 0.045,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.015),

                    // Jobs List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return _buildJobCard(
                          job,
                          isDarkMode,
                          width,
                          height,
                        );
                      },
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title,
      String value,
      bool isDarkMode,
      double width,
      double height, {
        bool showFilter = false,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: width * 0.032,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? AppColor.textSecondary : Colors.black87,
                        ),
                      ),
                    ),
                    if (showFilter)
                      GestureDetector(
                        onTap: _showFilterPopup,
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list_rounded,
                              color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                              size: width * 0.04,
                            ),
                            SizedBox(width: width * 0.005),
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: width * 0.028,
                                color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: height * 0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: width * 0.065,
                        fontWeight: FontWeight.w800,
                        color: AppColor.primary,
                      ),
                    ),
                    // Stats Image instead of Icon
                    Image.asset(
                      ImageAssets.statsImage,
                      width: width * 0.1,
                      height: width * 0.1,
                      fit: BoxFit.contain,

                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(
      Map<String, dynamic> job,
      bool isDarkMode,
      double width,
      double height,
      ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => OttoBuddyJobDetailScreen()),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.015),
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
          borderRadius: BorderRadius.circular(16),
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
                Text(
                  job['name'],
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                  ),
                ),
                if (job['isNew'] == true)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.025,
                      vertical: height * 0.004,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'New',
                      style: TextStyle(
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E88E5),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: height * 0.006),
            Text(
              job['car'],
              style: TextStyle(
                fontSize: width * 0.035,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: height * 0.004),
            Text(
              job['service'],
              style: TextStyle(
                fontSize: width * 0.033,
                color: AppColor.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.008),
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                  size: width * 0.035,
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: Text(
                    job['location'],
                    style: TextStyle(
                      fontSize: width * 0.03,
                      color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}