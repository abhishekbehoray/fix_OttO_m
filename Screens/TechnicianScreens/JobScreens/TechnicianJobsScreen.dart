// TechnicianJobsScreen.dart
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/JobScreens/TechnicianJobDetailScreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class TechnicianJobsScreen extends StatefulWidget {
  final VoidCallback? onGoHome;
  const TechnicianJobsScreen({super.key, this.onGoHome});

  @override
  State<TechnicianJobsScreen> createState() => _TechnicianJobsScreenState();
}

class _TechnicianJobsScreenState extends State<TechnicianJobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) widget.onGoHome?.call();
      },
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
                child: Center(
                  child: Text(
                    'Jobs',
                    style: TextStyle(
                      fontSize: width * 0.065,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                ),
              ),

              // ── Tab Bar ──
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.08)
                          : Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF2FB84C),
                  unselectedLabelColor: isDarkMode
                      ? AppColor.textSecondary
                      : Colors.grey.shade600,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: const Color(0xFF2FB84C),
                  indicatorWeight: 2.5,
                  dividerColor: Colors.transparent,
                  labelPadding: EdgeInsets.symmetric(horizontal: width * 0.01),
                  isScrollable: false,
                  labelStyle: TextStyle(
                    fontSize: width * 0.034,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: width * 0.034,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: 'New Jobs'),
                    Tab(text: 'Ongoing'),
                    Tab(text: 'Rejected'),
                    Tab(text: 'Completed'),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              // ── Tab Content ──
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildJobList('New', isDarkMode, width, height),
                    _buildJobList('Ongoing', isDarkMode, width, height),
                    _buildJobList('Rejected', isDarkMode, width, height),
                    _buildJobList('Completed', isDarkMode, width, height),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobList(String status, bool isDarkMode, double width, double height) {
    List<Map<String, String>> jobs = [];

    if (status == 'New') {
      jobs = [
        {'id': 'BK1023', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1024', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1025', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1026', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
      ];
    } else if (status == 'Ongoing') {
      jobs = [
        {'id': 'BK1023', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1024', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1025', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
      ];
    } else if (status == 'Rejected') {
      jobs = [
        {'id': 'BK1023', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1024', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1025', 'title': 'Car Services', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
      ];
    } else {
      jobs = [
        {'id': 'BK1023', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1024', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1025', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
        {'id': 'BK1026', 'title': 'Car Service', 'subtitle': 'Basic Service', 'customer': 'Rahul Sharma'},
      ];
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      physics: const BouncingScrollPhysics(),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TechnicianJobDetailScreen(
                  jobId: jobs[index]['id'] ?? '',
                  showAcceptButton: status == 'New',
                  showEnterOtpButton: status == 'Rejected',
                  initialStage: status == 'Ongoing' ? JobStage.accepted : null,
                ),
              ),
            );
          },
          child: _buildJobCard(
            jobs[index],
            status,
            isDarkMode,
            width,
            height,
            index == jobs.length - 1,
          ),
        );
      },
    );
  }

  Widget _buildJobCard(
      Map<String, String> job,
      String status,
      bool isDarkMode,
      double width,
      double height,
      bool isLast,
      ) {
    Color statusColor;
    if (status == 'New') {
      statusColor = const Color(0xFF2FB84C);
    } else if (status == 'Ongoing') {
      statusColor = const Color(0xFFFFA500);
    } else if (status == 'Rejected') {
      statusColor = const Color(0xFFE74C3C);
    } else {
      statusColor = const Color(0xFF3498DB);
    }

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : height * 0.018),
      padding: EdgeInsets.all(width * 0.035),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      job['id'] ?? '',
                      style: TextStyle(
                        fontSize: width * 0.033,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.002,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: width * 0.026,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.008),
                Text(
                  job['title'] ?? '',
                  style: TextStyle(
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  job['subtitle'] ?? '',
                  style: TextStyle(
                    fontSize: width * 0.032,
                    color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: height * 0.006),
                Text(
                  'Customer: ${job['customer'] ?? ''}',
                  style: TextStyle(
                    fontSize: width * 0.03,
                    color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.03),
          Container(
            width: width * 0.26,
            height: width * 0.24,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.car_repair_rounded,
                size: width * 0.08,
                color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
