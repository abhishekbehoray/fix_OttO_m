// TechnicianAddMoneyScreen.dart
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';

class TechnicianAddMoneyScreen extends StatefulWidget {
  const TechnicianAddMoneyScreen({super.key});

  @override
  State<TechnicianAddMoneyScreen> createState() => _TechnicianAddMoneyScreenState();
}

class _TechnicianAddMoneyScreenState extends State<TechnicianAddMoneyScreen> {
  String _displayAmount = '00.00';
  String _rawAmount = '';

  void _onValueChanged(String value) {
    setState(() {
      _rawAmount = value;

      if (value.isEmpty) {
        _displayAmount = '00.00';
      } else if (!value.contains('.')) {
        _displayAmount = value;
      } else {
        final parts = value.split('.');
        final whole = parts[0];
        final decimal = parts.length > 1 ? parts[1] : '';

        if (decimal.isEmpty) {
          _displayAmount = '$whole.';
        } else if (decimal.length == 1) {
          _displayAmount = '$whole.${decimal}0';
        } else {
          _displayAmount = '$whole.${decimal.substring(0, 2)}';
        }
      }
    });
  }

  void _addAmount() {
    final amount = double.tryParse(_displayAmount) ?? 0.0;
    if (amount > 0) {
      Navigator.pop(context, amount);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final amount = double.tryParse(_displayAmount) ?? 0.0;
    final isValidAmount = amount > 0;
    final bool isEmpty = _rawAmount.isEmpty;

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
          bottom: true,
          child: Column(
            children: [
              // ── App bar ──
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 20, 8),
                child: Row(
                  children: [
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
                    Expanded(
                      child: Center(
                        child: Text(
                          'Add amount',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              // ── Amount display ──
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Enter Amount',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 1.4,
                            height: 26,
                            margin: const EdgeInsets.only(right: 6, bottom: 6),
                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              '₹',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: isEmpty
                                    ? (isDarkMode ? AppColor.textTertiary : Colors.grey.shade400)
                                    : (isDarkMode ? AppColor.textPrimary : Colors.black87),
                              ),
                            ),
                          ),
                          Text(
                            _displayAmount,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              color: isEmpty
                                  ? (isDarkMode ? AppColor.textTertiary : Colors.grey.shade400)
                                  : (isDarkMode ? AppColor.textPrimary : Colors.black87),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 2,
                        width: 150,
                        color: isEmpty
                            ? (isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.shade300)
                            : AppColor.primary,
                      ),
                    ],
                  ),
                ),
              ),

              // ── Numpad ──
              _buildNumpad(isDarkMode),

              const SizedBox(height: 16),

              // ── Pay using + Add Amount ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF002E6E),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'P',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF00BAF2),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'PAY USING',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Paytm UPI',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _addAmount,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        decoration: BoxDecoration(
                          color: isValidAmount ? AppColor.primary : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Text(
                          'Add Amount',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isValidAmount ? Colors.white : Colors.grey.shade500,
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
      ),
    );
  }

  Widget _buildNumpad(bool isDarkMode) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNumpadRow(['1', '2', '3'], isDarkMode),
        const SizedBox(height: 12),
        _buildNumpadRow(['4', '5', '6'], isDarkMode),
        const SizedBox(height: 12),
        _buildNumpadRow(['7', '8', '9'], isDarkMode),
        const SizedBox(height: 12),
        _buildNumpadRow(['.', '0', '⌫'], isDarkMode),
      ],
    );
  }

  Widget _buildNumpadRow(List<String> keys, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) => _buildNumpadKey(key, isDarkMode)).toList(),
    );
  }

  Widget _buildNumpadKey(String label, bool isDarkMode) {
    final isBackspace = label == '⌫';
    final isDecimal = label == '.';
    final textColor = isDecimal ? AppColor.primary : (isDarkMode ? AppColor.textPrimary : Colors.black87);

    return GestureDetector(
      onTap: () {
        if (isBackspace) {
          _onValueChanged(_rawAmount.isNotEmpty ? _rawAmount.substring(0, _rawAmount.length - 1) : '');
        } else if (isDecimal) {
          if (!_rawAmount.contains('.')) {
            _onValueChanged(_rawAmount.isEmpty ? '0.' : '$_rawAmount.');
          }
        } else {
          final parts = _rawAmount.split('.');
          if (parts.length > 1 && parts[1].length >= 2) return;
          if (parts[0].length >= 8 && !_rawAmount.contains('.')) return;
          _onValueChanged('$_rawAmount$label');
        }
      },
      child: Container(
        width: 72,
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: isBackspace
            ? Icon(Icons.backspace_outlined, size: 24, color: textColor)
            : Text(
          label,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: textColor),
        ),
      ),
    );
  }
}