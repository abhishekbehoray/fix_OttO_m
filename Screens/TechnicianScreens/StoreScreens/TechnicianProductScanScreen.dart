// TechnicianProductScanScreen.dart
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TechnicianProductScanScreen extends StatefulWidget {
  const TechnicianProductScanScreen({super.key});

  @override
  State<TechnicianProductScanScreen> createState() => _TechnicianProductScanScreenState();
}

class _TechnicianProductScanScreenState extends State<TechnicianProductScanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanAnimationController;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    _scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),

    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    super.dispose();
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
                    Text(
                      'Scan Product',
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.qr_code_scanner_rounded,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                      size: width * 0.06,
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

              // ── Camera Preview (Centered) ──
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Container(
                      width: double.infinity,
                      height: height * 0.55,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.08)
                              : Colors.grey.shade200,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Camera Preview Placeholder
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  size: width * 0.15,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Scanning...',
                                  style: TextStyle(
                                    fontSize: width * 0.035,
                                    color: Colors.white54,
                                  ),
                                ),
                                SizedBox(height: height * 0.005),
                                Text(
                                  'Place QR code in the center',
                                  style: TextStyle(
                                    fontSize: width * 0.03,
                                    color: Colors.white38,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ── Corner Borders ──
                          Positioned(
                            top: 30,
                            left: 30,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: AppColor.primary, width: 4),
                                  left: BorderSide(color: AppColor.primary, width: 4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            right: 30,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: AppColor.primary, width: 4),
                                  right: BorderSide(color: AppColor.primary, width: 4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 30,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: AppColor.primary, width: 4),
                                  left: BorderSide(color: AppColor.primary, width: 4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            right: 30,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: AppColor.primary, width: 4),
                                  right: BorderSide(color: AppColor.primary, width: 4),
                                ),
                              ),
                            ),
                          ),

                          // ── Scanning Line Animation ──
                          Positioned(
                            left: 40,
                            right: 40,
                            child: AnimatedBuilder(
                              animation: _scanAnimationController,
                              builder: (context, child) {
                                return Positioned(
                                  top: _scanAnimationController.value *
                                      (height * 0.55 - 80) + 40,
                                  child: Container(
                                    height: 2,
                                    width: width * 0.8,
                                    color: AppColor.primary.withOpacity(0.8),
                                    child: Container(
                                      width: 40,
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // ── Scan Button at Bottom of Camera ──
                          Positioned(
                            bottom: 30,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Simulate scan and navigate back
                                  setState(() {
                                    _isScanning = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Product scanned successfully!'),
                                      backgroundColor: AppColor.primary,
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                  // Navigate back to all products screen after scan
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.08,
                                    vertical: height * 0.015,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.qr_code_scanner_rounded,
                                        color: AppColor.primary,
                                        size: width * 0.05,
                                      ),
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        'Scan Now',
                                        style: TextStyle(
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              // ── Bottom Info ──
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: width * 0.04,
                      color: isDarkMode ? Colors.white54 : Colors.grey.shade400,
                    ),
                    SizedBox(width: width * 0.015),
                    Text(
                      'Point camera at QR code to scan',
                      style: TextStyle(
                        fontSize: width * 0.03,
                        color: isDarkMode ? Colors.white54 : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}