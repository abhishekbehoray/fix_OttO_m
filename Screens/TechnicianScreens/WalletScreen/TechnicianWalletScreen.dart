// TechnicianWalletScreen.dart
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/WalletScreen/Technicianwithdrawamountscreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Utils/ImageAssets.dart';
import 'TechnicianAddMoneyScreen.dart';
import 'TechnicianAllTransactionsScreen.dart';

class TechnicianWalletScreen extends StatefulWidget {
  const TechnicianWalletScreen({super.key});

  @override
  State<TechnicianWalletScreen> createState() => _TechnicianWalletScreenState();
}

class _TechnicianWalletScreenState extends State<TechnicianWalletScreen> {
  bool _isWalletTab = true;

  double _walletBalance = 1200.00;
  double _todayEarning = 14235.00;
  double _totalEarning = 45678.00;
  final String _earningDate = '12th Nov, 2025';

  List<Map<String, String>> _walletTransactions = [];
  List<Map<String, String>> _earningTransactions = [];

  static const Color _screenBg = Color(0xFF1E1E1E);
  static const Color _cardDark = Color(0xFF2B2B2B);
  static const Color _green = Color(0xFF2FB84C);

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  void _loadSampleData() {
    _walletTransactions = [
      {'title': 'Top up', 'subtitle': 'Added to wallet', 'timeAgo': 'Today 12:39', 'amount': '+₹430.00'},
      {'title': 'Withdraw', 'subtitle': 'Transferred to bank', 'timeAgo': 'Yesterday 02:12', 'amount': '-₹430.00'},
      {'title': 'Top up', 'subtitle': 'Added to wallet', 'timeAgo': '2 days ago', 'amount': '+₹1000.00'},
      {'title': 'Top up', 'subtitle': 'Added to wallet', 'timeAgo': '3 days ago', 'amount': '+₹250.00'},
    ];
    _earningTransactions = [
      {'title': 'Service Payment', 'subtitle': 'AC Repair - Job #1245', 'timeAgo': 'Today 11:30', 'amount': '+₹850.00'},
      {'title': 'Service Payment', 'subtitle': 'Washing Machine - Job #1243', 'timeAgo': 'Today 09:15', 'amount': '+₹650.00'},
      {'title': 'Service Payment', 'subtitle': 'Refrigerator - Job #1240', 'timeAgo': 'Yesterday 04:20', 'amount': '+₹1200.00'},
      {'title': 'Bonus', 'subtitle': 'Performance bonus', 'timeAgo': '2 days ago', 'amount': '+₹500.00'},
    ];
  }

  String _formatIndianNumber(num value) {
    final int n = value.round();
    String s = n.abs().toString();
    final bool neg = n < 0;
    if (s.length <= 3) return (neg ? '-' : '') + s;
    final String last3 = s.substring(s.length - 3);
    final String rest = s.substring(0, s.length - 3);
    final StringBuffer buffer = StringBuffer();
    int count = 0;
    for (int i = rest.length - 1; i >= 0; i--) {
      buffer.write(rest[i]);
      count++;
      if (count % 2 == 0 && i != 0) buffer.write(',');
    }
    final String restFormatted = buffer.toString().split('').reversed.join();
    return '${neg ? '-' : ''}$restFormatted,$last3';
  }

  Future<void> _goToAddMoney() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TechnicianAddMoneyScreen()),
    );
    if (result != null && result is double) {
      setState(() {
        _walletBalance += result;
        _walletTransactions.insert(0, {
          'title': 'Top up',
          'subtitle': 'Added to wallet',
          'timeAgo': 'Just now',
          'amount': '+₹${result.toStringAsFixed(2)}',
        });
      });
    }
  }

  Future<void> _goToWithdraw() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TechnicianWithdrawAmountScreen()),
    );
    if (result != null && result is double) {
      setState(() {
        _walletBalance -= result;
        _walletTransactions.insert(0, {
          'title': 'Withdraw',
          'subtitle': 'Transferred to bank',
          'timeAgo': 'Just now',
          'amount': '-₹${result.toStringAsFixed(2)}',
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: _screenBg,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),

                // ── Back button ──
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: width * 0.1,
                      height: width * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_rounded, color: Colors.white, size: width * 0.05),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                // ── Wallet / Earning toggle ──
                Center(child: _buildToggle(width, height)),

                SizedBox(height: height * 0.028),

                // ── Balance / Earnings Card ──
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: _isWalletTab
                      ? _buildBalanceCard(width, height)
                      : _buildEarningCard(width, height),
                ),

                SizedBox(height: height * 0.02),

                // ── Actions ──
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: _isWalletTab
                      ? _buildWalletActions(width, height)
                      : _buildEarningSummary(width, height),
                ),

                SizedBox(height: height * 0.03),

                // ── Transactions (white sheet) ──
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(minHeight: height * 0.4),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.025, width * 0.05, height * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isWalletTab ? 'Wallet Transactions' : 'Earning Transactions',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TechnicianAllTransactionsScreen(
                                  isWalletTab: _isWalletTab,
                                  transactions: _isWalletTab ? _walletTransactions : _earningTransactions,
                                ),
                              ),
                            ),
                            child: Text(
                              'View all',
                              style: TextStyle(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: _green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.012),
                      _buildTransactionList(
                        _isWalletTab ? _walletTransactions : _earningTransactions,
                        width,
                        height,
                        isDarkMode,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggle(double width, double height) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleSegment('Wallet', _isWalletTab, width),
          _buildToggleSegment('Earning', !_isWalletTab, width),
        ],
      ),
    );
  }

  Widget _buildToggleSegment(String label, bool selected, double width) {
    return GestureDetector(
      onTap: () => setState(() => _isWalletTab = label == 'Wallet'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: width * 0.028),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: width * 0.04,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.black87 : Colors.white54,
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(width * 0.055),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2FB84C),
                  Color(0xFF1E8E3E),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Wallet',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: height * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Active',
                        style: TextStyle(
                          fontSize: width * 0.025,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.012),
                Text(
                  '₹${_formatIndianNumber(_walletBalance)}',
                  style: TextStyle(
                    fontSize: width * 0.09,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.03),
              ],
            ),
          ),
          Positioned(
            right: -width * 0.02,
            bottom: -height * 0.01,
            child: Image.asset(
              ImageAssets.walletImage,
              width: width * 0.28,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                width: width * 0.2,
                height: width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  size: width * 0.12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningCard(double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(width * 0.055),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2FB84C),
                  Color(0xFF1E8E3E),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Earnings',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: height * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Total: ₹${_formatIndianNumber(_totalEarning)}',
                        style: TextStyle(
                          fontSize: width * 0.025,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.012),
                Text(
                  '₹${_formatIndianNumber(_todayEarning)}',
                  style: TextStyle(
                    fontSize: width * 0.09,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Text(
                  'Today\'s Earning',
                  style: TextStyle(
                    fontSize: width * 0.032,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
          Positioned(
            right: -width * 0.01,
            bottom: -height * 0.012,
            child: Image.asset(
              ImageAssets.earningImage,
              width: width * 0.26,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                width: width * 0.2,
                height: width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.savings_rounded,
                  size: width * 0.12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletActions(double width, double height) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.018),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(child: _buildActionButton(Icons.add_rounded, 'Top up', _goToAddMoney, width)),
          Container(width: 1, height: height * 0.05, color: Colors.white.withOpacity(0.12)),
          Expanded(child: _buildActionButton(Icons.arrow_downward_rounded, 'Withdraw', _goToWithdraw, width)),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap, double width) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: width * 0.11,
            height: width * 0.11,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: width * 0.05),
          ),
          SizedBox(height: width * 0.02),
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: width * 0.033,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningSummary(double width, double height) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _earningDate,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: width * 0.032,
                ),
              ),
              SizedBox(height: height * 0.004),
              Text(
                'Today\'s Earning',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.038,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${_formatIndianNumber(_todayEarning)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.004),
              Text(
                'Total: ₹${_formatIndianNumber(_totalEarning)}',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: width * 0.028,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(
      List<Map<String, String>> transactions,
      double width,
      double height,
      bool isDarkMode,
      ) {
    if (transactions.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.03),
        child: Center(
          child: Text(
            'No transactions yet',
            style: TextStyle(
              color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
            ),
          ),
        ),
      );
    }
    return Column(
      children: [
        for (int i = 0; i < transactions.length; i++)
          Column(
            children: [
              _buildTransactionItem(transactions[i], width, height, isDarkMode),
              if (i != transactions.length - 1)
                Divider(
                  height: 1,
                  color: isDarkMode ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildTransactionItem(
      Map<String, String> transaction,
      double width,
      double height,
      bool isDarkMode,
      ) {
    final String title = transaction['title'] ?? '';
    final String subtitle = transaction['subtitle'] ?? '';
    final bool isDebit = title.toLowerCase().contains('withdraw') || title.toLowerCase().contains('debited');
    final IconData iconData = isDebit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
    final Color iconColor = isDebit ? const Color(0xFFE74C3C) : const Color(0xFF2ECC71);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.013),
      child: Row(
        children: [
          Container(
            height: width * 0.1,
            width: width * 0.1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              size: width * 0.05,
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
                    color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: height * 0.002),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: width * 0.028,
                      color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                    ),
                  ),
                ],
                SizedBox(height: height * 0.002),
                Text(
                  transaction['timeAgo'] ?? '',
                  style: TextStyle(
                    fontSize: width * 0.028,
                    color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
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
              color: isDebit ? const Color(0xFFE74C3C) : const Color(0xFF2ECC71),
            ),
          ),
          SizedBox(width: width * 0.01),
          Icon(
            Icons.chevron_right_rounded,
            size: width * 0.05,
            color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}