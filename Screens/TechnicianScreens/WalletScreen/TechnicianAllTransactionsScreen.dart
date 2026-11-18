// TechnicianAllTransactionsScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TechnicianAllTransactionsScreen extends StatelessWidget {
  final bool isWalletTab;
  final List<Map<String, String>> transactions;

  const TechnicianAllTransactionsScreen({
    super.key,
    required this.isWalletTab,
    required this.transactions,
  });

  static const Color _green = Color(0xFF2FB84C);

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
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        body: SafeArea(
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── App bar ──
              Padding(
                padding: EdgeInsets.fromLTRB(8, height * 0.015, 20, 8),
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
                          borderRadius: BorderRadius.circular(20),
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
                      isWalletTab ? 'Wallet Transactions' : 'Earning Transactions',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black87,
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

              // ── Transaction List ──
              Expanded(
                child: transactions.isEmpty
                    ? Center(
                  child: Text(
                    'No transactions yet',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white54 : Colors.grey.shade500,
                      fontSize: width * 0.038,
                    ),
                  ),
                )
                    : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.02,
                  ),
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.08)
                        : Colors.grey.shade200,
                  ),
                  itemBuilder: (_, i) => _buildTransactionItem(
                    transactions[i],
                    width,
                    height,
                    isDarkMode,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
      Map<String, String> transaction,
      double width,
      double height,
      bool isDarkMode,
      ) {
    final String title = transaction['title'] ?? '';
    final bool isDebit = title.toLowerCase().contains('withdraw');
    final bool isEarning = title.toLowerCase().contains('earning');

    final IconData iconData = isDebit
        ? Icons.arrow_downward_rounded
        : isEarning
        ? Icons.trending_up_rounded
        : Icons.arrow_upward_rounded;

    final Color iconColor = isDebit ? const Color(0xFFE74C3C) : _green;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.015),
      child: Row(
        children: [
          Container(
            height: width * 0.11,
            width: width * 0.11,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              size: width * 0.055,
              color: iconColor,
            ),
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: width * 0.037,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  transaction['timeAgo'] ?? '',
                  style: TextStyle(
                    fontSize: width * 0.03,
                    color: isDarkMode ? Colors.white54 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            transaction['amount'] ?? '',
            style: TextStyle(
              fontSize: width * 0.037,
              fontWeight: FontWeight.w600,
              color: isDebit ? const Color(0xFFE74C3C) : _green,
            ),
          ),
          SizedBox(width: width * 0.01),
          Icon(
            Icons.chevron_right_rounded,
            size: width * 0.05,
            color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}