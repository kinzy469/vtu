import 'package:flutter/material.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';

class ElectricityTokenScreen extends StatefulWidget {
  const ElectricityTokenScreen({super.key});

  @override
  _ElectricityTokenScreenState createState() => _ElectricityTokenScreenState();
}

class _ElectricityTokenScreenState extends State<ElectricityTokenScreen> {
  String? selectedProvider;
  final _meterNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  List<double> get predefinedAmounts {
    return [1000, 2000, 5000, 10000, 20000]; // Common amounts for electricity tokens
  }

  @override
  void dispose() {
    _meterNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _setAmount(double amount) {
    setState(() {
      _amountController.text = amount.toStringAsFixed(0);
    });
  }

  void _handlePurchase() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1)); // Simulate network call
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Purchasing ₦${_amountController.text} token for $selectedProvider'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColor.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ),
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Electricity Token Purchase",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: AppColor.secondary,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.secondary, AppColor.secondary.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Provider Selection Section
              Text(
                "Select Provider",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  NetworkCard(
                    name: "Ikeja Electric",
                    color: Colors.blue[700]!,
                    imageAsset: 'assets/provider_logo/ikeja_electric_logo.png',
                    isSelected: selectedProvider == "Ikeja Electric",
                    onTap: () => setState(() => selectedProvider = "Ikeja Electric"),
                  ),
                  NetworkCard(
                    name: "Eko Electric",
                    color: Colors.red[700]!,
                    imageAsset: 'assets/provider_logo/eko_electric_logo.png',
                    isSelected: selectedProvider == "Eko Electric",
                    onTap: () => setState(() => selectedProvider = "Eko Electric"),
                  ),
                  NetworkCard(
                    name: "PHCN",
                    color: Colors.green[700]!,
                    imageAsset: 'assets/provider_logo/phcn_logo.png',
                    isSelected: selectedProvider == "PHCN",
                    onTap: () => setState(() => selectedProvider = "PHCN"),
                  ),
                  NetworkCard(
                    name: "Kaduna Electric",
                    color: Colors.orange[700]!,
                    imageAsset: 'assets/provider_logo/kaduna_electric_logo.png',
                    isSelected: selectedProvider == "Kaduna Electric",
                    onTap: () => setState(() => selectedProvider = "Kaduna Electric"),
                  ),
                  NetworkCard(
                    name: "Abuja Electric",
                    color: Colors.purple[700]!,
                    imageAsset: 'assets/provider_logo/abuja_electric_logo.png',
                    isSelected: selectedProvider == "Abuja Electric",
                    onTap: () => setState(() => selectedProvider = "Abuja Electric"),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Input Fields Section
              Text(
                "Enter Details",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 4,
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInputField(
                        label: "Meter Number",
                        hint: selectedProvider == null ? "Enter 11-digit Meter Number" : "Enter $selectedProvider Meter Number",
                        icon: Icons.electrical_services,
                        keyboardType: TextInputType.number,
                        controller: _meterNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a meter number';
                          }
                          if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                            return 'Enter a valid 11-digit meter number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        label: "Amount (₦)",
                        hint: "Enter Purchase Amount",
                        icon: Icons.money,
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          final amount = double.tryParse(value);
                          if (amount == null || amount <= 0) {
                            return 'Enter a valid amount';
                          }
                          if (amount < 500) {
                            return 'Minimum amount is ₦500';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                        child: Wrap(
                          key: ValueKey(selectedProvider),
                          spacing: 8,
                          runSpacing: 8,
                          children: predefinedAmounts.map((amount) {
                            final isSelected = _amountController.text == amount.toStringAsFixed(0);
                            return ChoiceChip(
                              label: Text('₦${amount.toStringAsFixed(0)}'),
                              selected: isSelected,
                              onSelected: (selected) => _setAmount(amount),
                              selectedColor: AppColor.secondary.withOpacity(0.2),
                              backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                              labelStyle: TextStyle(
                                color: isSelected ? AppColor.secondary : textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: isSelected ? AppColor.secondary : Colors.grey[400]!,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: selectedProvider == null || _amountController.text.isEmpty || _isLoading
                      ? null
                      : _handlePurchase,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.secondary, AppColor.secondary.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Purchase Token",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// NetworkCard with animation
class NetworkCard extends StatelessWidget {
  final String name;
  final Color color;
  final String? imageAsset;
  final String? imageEmoji;
  final bool isSelected;
  final VoidCallback onTap;

  const NetworkCard({
    required this.name,
    required this.color,
    this.imageAsset,
    this.imageEmoji,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3.5 - 16,
          child: Material(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            elevation: isSelected ? 6 : 2,
            shadowColor: isSelected ? AppColor.secondary.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: isSelected ? Border.all(color: AppColor.secondary, width: 2) : null,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.9),
                    radius: 22,
                    child: imageAsset != null
                        ? ClipOval(
                            child: Image.asset(
                              imageAsset!,
                              height: 32,
                              width: 32,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Text(
                            imageEmoji ?? '',
                            style: const TextStyle(fontSize: 18),
                          ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: isSelected ? AppColor.secondary : textColor,
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

// CustomInputField with hint text
class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomInputField({
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.controller,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fillColor = Theme.of(context).inputDecorationTheme.fillColor ??
        (Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white);
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(color: textColor.withOpacity(0.7), fontSize: 16),
        hintStyle: TextStyle(color: textColor.withOpacity(0.5), fontSize: 14),
        prefixIcon: Icon(icon, color: AppColor.secondary, size: 20),
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red[400]!, width: 2),
        ),
        errorStyle: const TextStyle(fontSize: 12),
      ),
      style: TextStyle(color: textColor, fontSize: 16),
    );
  }
}