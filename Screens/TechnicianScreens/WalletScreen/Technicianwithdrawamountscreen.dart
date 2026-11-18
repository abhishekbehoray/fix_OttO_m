// TechnicianWithdrawAmountScreen.dart
import 'package:fixottobuddy_techni/Screens/TechnicianScreens/WalletScreen/Technicianselectbankscreen.dart';
import 'package:fixottobuddy_techni/Utils/AppColor.dart';
import 'package:flutter/material.dart';


class TechnicianWithdrawAmountScreen extends StatefulWidget {
  const TechnicianWithdrawAmountScreen({super.key});

  @override
  State<TechnicianWithdrawAmountScreen> createState() => _TechnicianWithdrawAmountScreenState();
}

class _TechnicianWithdrawAmountScreenState extends State<TechnicianWithdrawAmountScreen> {
  String _displayAmount = '00.00';
  String _rawAmount = '';
  BankAccount? _selectedBank;

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

  Future<void> _pickBankAccount() async {
    final BankAccount? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TechnicianSelectBankScreen()),
    );
    if (result != null) {
      setState(() => _selectedBank = result);
    }
  }

  void _withdrawAmount() {
    final amount = double.tryParse(_displayAmount) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_selectedBank == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a bank account'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.pop(context, amount);
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
                          'Withdraw Amount',
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

              // ── Select Account + Withdraw ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _pickBankAccount,
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance_rounded,
                              size: 18,
                              color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_selectedBank != null)
                                    Text(
                                      'BANK',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode ? AppColor.textTertiary : Colors.grey.shade500,
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _selectedBank?.name ?? 'Select Account',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: isDarkMode ? AppColor.textPrimary : Colors.black87,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18,
                                        color: isDarkMode ? AppColor.textSecondary : Colors.grey.shade600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _withdrawAmount,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        decoration: BoxDecoration(
                          color: isValidAmount ? AppColor.primary : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Text(
                          // NOTE: kept as "Add Amount" to match the provided design
                          // exactly; swap the label to "Withdraw" if that was a
                          // copy/paste artifact in the mockup.
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