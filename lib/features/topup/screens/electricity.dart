import 'package:flutter/material.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for consistent typography

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
    return [1000, 2000, 5000, 10000, 20000];
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
      await Future.delayed(const Duration(seconds: 1));
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Electricity Token Purchase",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: screenWidth * 0.05, // Responsive font size
          ),
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
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Provider",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3, // 3 boxes per row for better balance
                crossAxisSpacing: screenWidth * 0.03,
                mainAxisSpacing: screenHeight * 0.015,
                childAspectRatio: 0.8, // Taller boxes for better proportion
                children: [
                  NetworkCard(
                    name: "Ikeja Electric",
                    color: Colors.blue[700]!,
                    isSelected: selectedProvider == "Ikeja Electric",
                    onTap: () => setState(() => selectedProvider = "Ikeja Electric"),
                  ),
                  NetworkCard(
                    name: "Eko Electric",
                    color: Colors.red[700]!,
                    isSelected: selectedProvider == "Eko Electric",
                    onTap: () => setState(() => selectedProvider = "Eko Electric"),
                  ),
                  NetworkCard(
                    name: "PHCN",
                    color: Colors.green[700]!,
                    isSelected: selectedProvider == "PHCN",
                    onTap: () => setState(() => selectedProvider = "PHCN"),
                  ),
                  NetworkCard(
                    name: "Kaduna Electric",
                    color: Colors.orange[700]!,
                    isSelected: selectedProvider == "Kaduna Electric",
                    onTap: () => setState(() => selectedProvider = "Kaduna Electric"),
                  ),
                  NetworkCard(
                    name: "Abuja Electric",
                    color: Colors.purple[700]!,
                    isSelected: selectedProvider == "Abuja Electric",
                    onTap: () => setState(() => selectedProvider = "Abuja Electric"),
                  ),
                  NetworkCard(
                    name: "BEDC - Benin",
                    color: Colors.teal[700]!,
                    isSelected: selectedProvider == "BEDC - Benin",
                    onTap: () => setState(() => selectedProvider = "BEDC - Benin"),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                "Enter Details",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Card(
                elevation: 4,
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
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
                      SizedBox(height: screenHeight * 0.02),
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
                      SizedBox(height: screenHeight * 0.02),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                        child: Wrap(
                          key: ValueKey(selectedProvider),
                          spacing: screenWidth * 0.02,
                          runSpacing: screenHeight * 0.01,
                          children: predefinedAmounts.map((amount) {
                            final isSelected = _amountController.text == amount.toStringAsFixed(0);
                            return ChoiceChip(
                              label: Text('₦${amount.toStringAsFixed(0)}'),
                              selected: isSelected,
                              onSelected: (selected) => _setAmount(amount),
                              selectedColor: AppColor.secondary.withOpacity(0.2),
                              backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                              labelStyle: GoogleFonts.poppins(
                                color: isSelected ? AppColor.secondary : textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.035,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: isSelected ? AppColor.secondary : Colors.grey[400]!,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 8),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
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
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    child: Center(
                      child: _isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              "Purchase Token",
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated NetworkCard with responsive sizing
class NetworkCard extends StatelessWidget {
  final String name;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const NetworkCard({
    required this.name,
    required this.color,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: SizedBox(
          width: screenWidth * 0.3 - 16, // Responsive width (30% of screen width minus padding)
          height: screenWidth * 0.35, // Slightly taller for better proportion
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
              padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.9),
                    radius: screenWidth * 0.06, // Responsive radius
                    child: Icon(
                      Icons.lightbulb,
                      color: Colors.white,
                      size: screenWidth * 0.07, // Responsive icon size
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.035, // Responsive font size
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

// Reusable input field
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
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: GoogleFonts.poppins(
          color: textColor.withOpacity(0.7),
          fontSize: screenWidth * 0.04,
        ),
        hintStyle: GoogleFonts.poppins(
          color: textColor.withOpacity(0.5),
          fontSize: screenWidth * 0.035,
        ),
        prefixIcon: Icon(icon, color: AppColor.secondary, size: screenWidth * 0.05),
        filled: true,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.04, horizontal: screenWidth * 0.04),
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
        errorStyle: GoogleFonts.poppins(fontSize: screenWidth * 0.03),
      ),
      style: GoogleFonts.poppins(
        color: textColor,
        fontSize: screenWidth * 0.04,
      ),
    );
  }
}