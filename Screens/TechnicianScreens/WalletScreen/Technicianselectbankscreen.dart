// TechnicianSelectBankScreen.dart
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class BankAccount {
  final String name;
  final String assetPath;
  final Color fallbackColor;

  const BankAccount({
    required this.name,
    required this.assetPath,
    required this.fallbackColor,
  });
}

class TechnicianSelectBankScreen extends StatefulWidget {
  const TechnicianSelectBankScreen({super.key});

  @override
  State<TechnicianSelectBankScreen> createState() => _TechnicianSelectBankScreenState();
}

class _TechnicianSelectBankScreenState extends State<TechnicianSelectBankScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // TODO: point assetPath at your actual bank-logo assets (register in pubspec.yaml).
  // Falls back to an initials avatar if the asset isn't found.
  static const List<BankAccount> _banks = [
    BankAccount(name: 'SBI Bank', assetPath: 'assets/images/banks/sbi.png', fallbackColor: Color(0xFF1E5AA8)),
    BankAccount(name: 'PNB Bank', assetPath: 'assets/images/banks/pnb.png', fallbackColor: Color(0xFFF7941D)),
    BankAccount(name: 'ICICI Bank', assetPath: 'assets/images/banks/icici.png', fallbackColor: Color(0xFFB5262A)),
    BankAccount(name: 'HDFC Bank', assetPath: 'assets/images/banks/hdfc.png', fallbackColor: Color(0xFF004C8F)),
    BankAccount(name: 'Union Bank', assetPath: 'assets/images/banks/union.png', fallbackColor: Color(0xFFEF6C1F)),
    BankAccount(name: 'Axis Bank', assetPath: 'assets/images/banks/axis.png', fallbackColor: Color(0xFF97144D)),
    BankAccount(name: 'Canara Bank', assetPath: 'assets/images/banks/canara.png', fallbackColor: Color(0xFFF7A600)),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final List<BankAccount> filteredBanks = _query.isEmpty
        ? _banks
        : _banks.where((b) => b.name.toLowerCase().contains(_query.toLowerCase())).toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppColor.getOnboardingGradient(brightness)
              : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFFBF1EE)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.015),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
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
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  'Add your bank account for withdraw payments',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.02),

                // ── Search bar ──
                Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade200,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _query = v),
                    style: TextStyle(
                      fontSize: width * 0.038,
                      color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade500,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: height * 0.016),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

                // ── Bank grid ──
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredBanks.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: height * 0.025,
                      crossAxisSpacing: width * 0.03,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      final bank = filteredBanks[index];
                      return GestureDetector(
                        onTap: () => Navigator.pop(context, bank),
                        child: Column(
                          children: [
                            Container(
                              width: width * 0.18,
                              height: width * 0.18,
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.white.withOpacity(0.06) : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(width * 0.03),
                              child: ClipOval(
                                child: Image.asset(
                                  bank.assetPath,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: bank.fallbackColor,
                                    alignment: Alignment.center,
                                    child: Text(
                                      bank.name.substring(0, 1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              bank.name,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: width * 0.033,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}