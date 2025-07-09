import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';
import 'package:vtu_topup/features/home/screens/history.dart';
import 'package:vtu_topup/features/wallet/walletscreen.dart';

class Fundwallet extends StatelessWidget {
  Fundwallet({super.key});

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = isDark ? AppColor.textLight : AppColor.textDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fund Wallet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: textColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Amount",
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
                    labelText: "Amount (₦)",
                    prefixIcon: const Icon(Icons.money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an amount";
                    }
                    final amount = double.tryParse(value);
                    if (amount == null) return "Please enter a valid number";
                    if (amount < 100) return "Minimum amount is ₦100";
                    if (amount > 100000) return "Maximum amount is ₦100,000";
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final amount = _amountController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PaymentMethodScreen(amount: amount),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Fund Wallet",
                      style: TextStyle(fontSize: 16),
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
}

class PaymentMethodScreen extends StatefulWidget {
  final String amount;

  const PaymentMethodScreen({super.key, required this.amount});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  String? _paymentMethod = 'Card';

  final _currencyFormatter = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 0,
  );

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog(BuildContext context, String method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Text(
          'Fund wallet with ${widget.amount} using $method?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Successfully funded ${widget.amount} via $method',
                  ),
                ),
              );
              Navigator.popUntil(context, ModalRoute.withName('/wallet'));
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColor.backgroundDark : AppColor.background;
    final cardColor = isDark ? AppColor.cardDark : AppColor.cardLight;
    final textColor = isDark ? AppColor.textLight : AppColor.textDark;

    return Theme(
      data: ThemeData(
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Choose Payment Method',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: textColor,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.padding),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    'Amount: ${widget.amount}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Select Payment Method',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor,
                        ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _paymentMethod,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ['Card', 'Bank Transfer']
                        .map((method) => DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _paymentMethod = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a payment method' : null,
                  ),
                  const SizedBox(height: 24),
                  if (_paymentMethod == 'Card') ...[
                    Text(
                      'Card Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor,
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        prefixIcon: const Icon(Icons.credit_card),
                        filled: true,
                        fillColor: cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter card number';
                        }
                        if (value.replaceAll(' ', '').length != 16) {
                          return 'Card number must be 16 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _expiryController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Expiry (MM/YY)',
                              filled: true,
                              fillColor: cardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter expiry date';
                              }
                              if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$')
                                  .hasMatch(value)) {
                                return 'Enter valid MM/YY';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'CVV',
                              filled: true,
                              fillColor: cardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter CVV';
                              }
                              if (value.length != 3) {
                                return 'CVV must be 3 digits';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Text(
                      'Bank Transfer Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color: cardColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Please transfer ${widget.amount} to:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: textColor),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Bank: Zenith Bank\nAccount Number: 1234567890\nAccount Name: VTU Topup',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showConfirmationDialog(context, _paymentMethod!);
                        }
                      },
                      child: const Text(
                        'Proceed',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
