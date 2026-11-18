import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/JobScreens/JobCardScreenThree.dart';
import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/JobScreens/OttoBuddyJobDetailScreen.dart';
import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/WrapperScreens/OttoBuddyMainWrapper.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class OttoBuddyJobsScreen extends StatefulWidget {
  const OttoBuddyJobsScreen({super.key});

  @override
  State<OttoBuddyJobsScreen> createState() => _OttoBuddyJobsScreenState();
}

class _OttoBuddyJobsScreenState extends State<OttoBuddyJobsScreen> {
  String _selectedTab = 'New Jobs';

  final List<String> _tabs = ['New Jobs', 'Completed'];

  final List<Map<String, dynamic>> _newJobs = [
    {
      'name': 'Rajesh Kumar',
      'car': 'Honda City 2020',
      'service': 'Cleaning service',
      'location': 'Sector 62, Noida, Uttar Pradesh 201301',
      'status': 'New',
    },
    {
      'name': 'Rajesh Kumar',
      'car': 'Honda City 2020',
      'service': 'Cleaning service',
      'location': 'Sector 62, Noida, Uttar Pradesh 201301',
      'status': 'New',
    },
    {
      'name': 'Rajesh Kumar',
      'car': 'Honda City 2020',
      'service': 'Cleaning service',
      'location': 'Sector 62, Noida, Uttar Pradesh 201301',
      'status': 'New',
    },
  ];

  final List<Map<String, dynamic>> _completedJobs = [
    {
      'name': 'Rajesh Kumar',
      'car': 'Honda City 2020',
      'service': 'Cleaning service',
      'location': 'Sector 62, Noida, Uttar Pradesh 201301',
      'status': 'Completed',
    },
    {
      'name': 'Rajesh Kumar',
      'car': 'Honda City 2020',
      'service': 'Cleaning service',
      'location': 'Sector 62, Noida, Uttar Pradesh 201301',
      'status': 'Completed',
    },
    {
      'name': 'Rajesh Kumar',
      'car': 'Honda City 2020',
      'service': 'Cleaning service',
      'location': 'Sector 62, Noida, Uttar Pradesh 201301',
      'status': 'Completed',
    },
  ];

  List<Map<String, dynamic>> get _currentJobs {
    return _selectedTab == 'New Jobs' ? _newJobs : _completedJobs;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const OttoBuddyMainWrapper(initialIndex: 0)),
                (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: isDarkMode ? AppColor.getOnboardingGradient(brightness) : null,
            color: isDarkMode ? null : Colors.white,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.06,
                    vertical: height * 0.02,
                  ),
                  child: Center(
                    child: Text(
                      'Jobs',
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.01),

                // Segmented Tabs
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: _tabs.map((tab) {
                        final isSelected = _selectedTab == tab;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTab = tab;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              padding: EdgeInsets.symmetric(vertical: height * 0.014),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected ? AppColor.primary : Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                tab,
                                style: TextStyle(
                                  fontSize: width * 0.038,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : isDarkMode
                                      ? AppColor.textSecondary
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.025),

                // All Jobs Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: Text(
                    'All Jobs',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.015),

                // Jobs List
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                    child: ListView.builder(
                      itemCount: _currentJobs.length,
                      itemBuilder: (context, index) {
                        final job = _currentJobs[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => job['status'] == 'Completed'
                                  ? const JobCardScreenThree(isCompleted: true)
                                  : const OttoBuddyJobDetailScreen(),
                            ),
                          ),
                          child: _buildJobCard(job, isDarkMode, width, height),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobCard(
      Map<String, dynamic> job,
      bool isDarkMode,
      double width,
      double height,
      ) {
    final bool isNew = job['status'] == 'New';
    final Color statusColor = isNew ? const Color(0xFF1E88E5) : const Color(0xFF2FA84F);

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.06) : const Color(0xFFF2F1EF),
        borderRadius: BorderRadius.circular(16),
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
                  fontSize: width * 0.043,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  job['status'],
                  style: TextStyle(
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.008),
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
              color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: height * 0.01),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
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
    );
  }
}