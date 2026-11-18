import 'package:fixottobuddy_techni/Screens/OttoBuddyScreens/JobScreens/JobCardScreenThree.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:fixottobuddy_techni/Utils/ImageAssets.dart';
import 'package:flutter/material.dart';

class JobCardScreenTwo extends StatefulWidget {
  const JobCardScreenTwo({super.key});

  @override
  State<JobCardScreenTwo> createState() => _JobCardScreenTwoState();
}

class _JobCardScreenTwoState extends State<JobCardScreenTwo> {
  final TextEditingController _partsTimeController = TextEditingController();
  final TextEditingController _workTimeController = TextEditingController();
  final TextEditingController _partsCostController = TextEditingController();
  final TextEditingController _laborChargesController = TextEditingController();

  final List<Map<String, String>> _jobCardItems = [
    {'service': 'Lorem Ipsum', 'status': 'Check'},
    {'service': 'Lorem Ipsum', 'status': 'None'},
    {'service': 'Lorem Ipsum', 'status': 'Check'},
    {'service': 'Lorem Ipsum', 'status': 'Check'},
    {'service': 'Lorem Ipsum', 'status': 'None'},
    {'service': 'Lorem Ipsum', 'status': 'Check'},
    {'service': 'Lorem Ipsum', 'status': 'Check'},
    {'service': 'Lorem Ipsum', 'status': 'Check'},
    {'service': 'Lorem Ipsum', 'status': 'Check'},
    {'service': 'Lorem Ipsum', 'status': 'Check'},
  ];

  @override
  void dispose() {
    _partsTimeController.dispose();
    _workTimeController.dispose();
    _partsCostController.dispose();
    _laborChargesController.dispose();
    super.dispose();
  }

  // Toggles a row's status between Check and None.
  void _toggleStatus(int index) {
    setState(() {
      _jobCardItems[index]['status'] =
      _jobCardItems[index]['status'] == 'Check' ? 'None' : 'Check';
    });
  }

  // Appends a new row to the job card table.
  void _addService() {
    setState(() {
      _jobCardItems.add({'service': 'Lorem Ipsum', 'status': 'None'});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final Color cardColor = isDarkMode ? Colors.white.withOpacity(0.06) : Colors.grey.shade50;
    final Color cardBorder = isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200;

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
                horizontal: width * 0.06,
                vertical: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(width * 0.025),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.white,
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
                        child: Center(
                          child: Text(
                            'Details',
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

                  SizedBox(height: height * 0.02),

                  // Job Card Header
                  _buildJobCardHeader(isDarkMode, width, height, cardColor, cardBorder),

                  SizedBox(height: height * 0.02),

                  // Consolidated Customer / Vehicle / Service Card
                  Container(
                    padding: EdgeInsets.all(width * 0.045),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cardBorder, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Name', 'Rahul Sharma', isDarkMode, width),
                        _buildDetailRow('Phone Number', '+91 8023993884', isDarkMode, width),
                        _buildStatusRow('Status', 'New', isDarkMode, width, height),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.014),
                          child: Divider(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                            thickness: 1,
                            height: 0,
                          ),
                        ),

                        _buildSectionTitle('Vehicle Info', isDarkMode, width, padBottom: true),
                        _buildDetailRow('Vehicle Number', 'DI XX D5 1200', isDarkMode, width),
                        _buildDetailRow('Vehicle Type', 'Lorem Ipsum', isDarkMode, width),
                        _buildDetailRow('Model Number', 'Lorem Ipsum', isDarkMode, width),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.014),
                          child: Divider(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300,
                            thickness: 1,
                            height: 0,
                          ),
                        ),

                        _buildSectionTitle('Service Info', isDarkMode, width, padBottom: true),
                        _buildDetailRow('Service Name', 'Lorem Ipsum', isDarkMode, width),
                        _buildDetailRow('Package', 'Lorem Ipsum', isDarkMode, width),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Inspection Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.045),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cardBorder, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inspection',
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.014),
                        Text(
                          'Inspection Video',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: height * 0.012,
                                ),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? Colors.white.withOpacity(0.04) : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: cardBorder, width: 1),
                                ),
                                child: Text(
                                  'Video.Mp4',
                                  style: TextStyle(
                                    fontSize: width * 0.032,
                                    color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.014,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCEDEB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'View',
                                style: TextStyle(
                                  fontSize: width * 0.032,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF3F6B67),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Enter Details Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.045),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cardBorder, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Details',
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.014),
                        _buildTextField(
                          'Estimated Time To Arrange The Parts',
                          'Enter',
                          _partsTimeController,
                          isDarkMode,
                          width,
                          height,
                        ),
                        _buildTextField(
                          'Estimated Time To Complete The Work',
                          'Enter',
                          _workTimeController,
                          isDarkMode,
                          width,
                          height,
                        ),
                        _buildTextField(
                          'Additional Parts Cost',
                          'Enter',
                          _partsCostController,
                          isDarkMode,
                          width,
                          height,
                        ),
                        _buildTextField(
                          'Labor Charges',
                          'Enter',
                          _laborChargesController,
                          isDarkMode,
                          width,
                          height,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Job Card Table
                  Center(
                    child: Text(
                      'Job Card',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.012),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cardBorder, width: 1),
                    ),
                    child: Column(
                      children: [
                        // Header Row
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.012,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: width * 0.07),
                              VerticalDivider(color: cardBorder, thickness: 1, width: width * 0.05),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Service',
                                    style: TextStyle(
                                      fontSize: width * 0.033,
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                              VerticalDivider(color: cardBorder, thickness: 1, width: width * 0.05),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                      fontSize: width * 0.033,
                                      fontWeight: FontWeight.w600,
                                      color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: cardBorder, thickness: 1, height: 0),

                        // Data Rows
                        ..._jobCardItems.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final Map<String, String> item = entry.value;
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.012,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.07,
                                      child: Center(
                                        child: Text(
                                          (index + 1).toString().padLeft(2, '0'),
                                          style: TextStyle(
                                            fontSize: width * 0.03,
                                            color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(color: cardBorder, thickness: 1, width: width * 0.05),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          item['service']!,
                                          style: TextStyle(
                                            fontSize: width * 0.032,
                                            fontWeight: FontWeight.w500,
                                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(color: cardBorder, thickness: 1, width: width * 0.05),
                                    Expanded(
                                      child: Center(
                                        child: _buildStatusToggle(item['status']!, isDarkMode, width, height,
                                            onTap: () => _toggleStatus(index)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: cardBorder, thickness: 1, height: 0),
                            ],
                          );
                        }),

                        // Add Service Row
                        GestureDetector(
                          onTap: _addService,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.014,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.07,
                                  child: Center(
                                    child: Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: width * 0.05,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                ),
                                VerticalDivider(color: cardBorder, thickness: 1, width: width * 0.05),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Add Service',
                                      style: TextStyle(
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                VerticalDivider(color: cardBorder, thickness: 1, width: width * 0.05),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  // Confirm & Save Button
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JobCardScreenThree(),
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
                        'Confirm & Save',
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

  Widget _buildJobCardHeader(
      bool isDarkMode, double width, double height, Color cardColor, Color cardBorder) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.045),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cardBorder, width: 1),
      ),
      child: Column(
        children: [
          Text(
            'Job Card',
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
            ),
          ),
          SizedBox(height: height * 0.015),
          Row(
            children: [
              Image.asset(
                ImageAssets.statsImage,
                width: width * 0.2,
                height: width * 0.2,
                fit: BoxFit.contain,

              ),
              SizedBox(width: width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fixotto',
                    style: TextStyle(
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                  ),
                  Text(
                    'AUTOMOTIVE',
                    style: TextStyle(
                      fontSize: width * 0.026,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode, double width, {bool padBottom = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: padBottom ? width * 0.015 : 0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.w700,
          color: isDarkMode ? AppColor.textPrimary : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, bool isDarkMode, double width, double height) {
    final bool isNew = value == 'New';
    final Color statusColor = isNew ? const Color(0xFF1E88E5) : Colors.green;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.004,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label,
      String hint,
      TextEditingController controller,
      bool isDarkMode,
      double width,
      double height, {
        bool isLast = false,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : height * 0.014),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.032,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
            ),
          ),
          SizedBox(height: height * 0.006),
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withOpacity(0.04) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: width * 0.032,
                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: width * 0.032,
                  color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.012,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tappable Check / None badge for the Job Card table.
  Widget _buildStatusToggle(
      String status,
      bool isDarkMode,
      double width,
      double height, {
        required VoidCallback onTap,
      }) {
    final bool isCheck = status == 'Check';
    final Color color = isCheck
        ? Colors.green
        : (isDarkMode ? AppColor.textTertiary : Colors.grey.shade400);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.025,
          vertical: height * 0.006,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isCheck
                ? Colors.green.withOpacity(0.4)
                : (isDarkMode ? Colors.white.withOpacity(0.15) : Colors.grey.shade300),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, size: width * 0.04, color: color),
          ],
        ),
      ),
    );
  }
}