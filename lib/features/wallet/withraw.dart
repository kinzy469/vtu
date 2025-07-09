import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String? _selectedBank;

  final List<String> _banks = [
    'First Bank - 1234567890',
    'GTBank - 0987654321',
    'Zenith Bank - 1122334455',
  ];

  final _currencyFormatter = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      final text = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (text.isNotEmpty) {
        final number = double.tryParse(text);
        if (number != null) {
          final formatted = _currencyFormatter.format(number);
          if (formatted != _amountController.text) {
            _amountController.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: formatted.length),
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog(BuildContext context, String amount, String bank) {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColor.cardDark : AppColor.cardLight,
          title: const Text('Confirm Withdrawal'),
          content: Text(
            'Withdraw $amount to $bank?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.accent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Successfully withdrawn $amount to $bank')),
                );
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColor.textLight : AppColor.textDark;

    return Scaffold(
      backgroundColor: isDark ? AppColor.backgroundDark : AppColor.background,
      appBar: AppBar(
        title: const Text(
          'Withdraw Funds',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: textColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Bank Account',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textColor,
                      ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedBank,
                  hint: Text('Choose a bank account', style: TextStyle(color: textColor)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isDark ? AppColor.cardDark : AppColor.cardLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  dropdownColor: isDark ? AppColor.cardDark : AppColor.cardLight,
                  items: _banks.map((bank) {
                    return DropdownMenuItem(
                      value: bank,
                      child: Text(bank, style: TextStyle(color: textColor)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBank = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a bank account' : null,
                ),
                const SizedBox(height: 24),
                Text(
                  'Enter Amount',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textColor,
                      ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount (₦)',
                    labelStyle: TextStyle(color: textColor),
                    filled: true,
                    fillColor: isDark ? AppColor.cardDark : AppColor.cardLight,
                    prefixIcon: const Icon(Icons.money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: TextStyle(color: textColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
                    final amount = double.tryParse(cleaned);
                    if (amount == null) return 'Please enter a valid number';
                    if (amount < 500) return 'Minimum withdrawal is ₦500';
                    if (amount > 50000) return 'Maximum withdrawal is ₦50,000';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _selectedBank != null) {
                        final amount = _amountController.text;
                        _showConfirmationDialog(context, amount, _selectedBank!);
                      }
                    },
                    child: const Text('Withdraw', style: TextStyle(fontSize: 16)),
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
