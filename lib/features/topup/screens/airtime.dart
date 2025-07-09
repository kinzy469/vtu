import 'package:flutter/material.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';

class AirtimeTopupScreen extends StatefulWidget {
  const AirtimeTopupScreen({super.key});

  @override
  _AirtimeTopupScreenState createState() => _AirtimeTopupScreenState();
}

class _AirtimeTopupScreenState extends State<AirtimeTopupScreen> {
  String? selectedNetwork;
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<double> predefinedAmounts = [100, 200, 500, 1000, 2000];

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _setAmount(double amount) {
    setState(() {
      _amountController.text = amount.toStringAsFixed(0);
    });
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
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Buy Airtime",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Network Provider",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Network Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  NetworkCard(
                    name: "MTN",
                    color: Colors.yellow[700]!,
                    imageAsset: 'assets/airtime_logo/mtn_logo.jpeg',
                    isSelected: selectedNetwork == "MTN",
                    onTap: () => setState(() => selectedNetwork = "MTN"),
                  ),
                  NetworkCard(
                    name: "Airtel",
                    color: Colors.red[700]!,
                    imageAsset: 'assets/airtime_logo/Airtel_logo.jpeg',
                    isSelected: selectedNetwork == "Airtel",
                    onTap: () => setState(() => selectedNetwork = "Airtel"),
                  ),
                  NetworkCard(
                    name: "Glo",
                    color: Colors.green[700]!,
                    imageAsset: 'assets/airtime_logo/glo_logo.jpeg',
                    isSelected: selectedNetwork == "Glo",
                    onTap: () => setState(() => selectedNetwork = "Glo"),
                  ),
                  NetworkCard(
                    name: "9mobile",
                    color: Colors.teal[700]!,
                    imageAsset: 'assets/airtime_logo/9mobile_logo.jpeg',
                    isSelected: selectedNetwork == "9mobile",
                    onTap: () => setState(() => selectedNetwork = "9mobile"),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Card(
                elevation: 4,
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInputField(
                        label: "Phone Number",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomInputField(
                        label: "Amount (₦)",
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
                          if (amount < 50) {
                            return 'Minimum amount is ₦50';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Wrap(
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
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: isSelected ? AppColor.secondary : Colors.grey[400]!,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  onPressed: selectedNetwork == null || _amountController.text.isEmpty
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Purchasing ₦${_amountController.text} airtime for $selectedNetwork',
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: AppColor.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }
                        },
                  child: const Text(
                    "Buy Airtime",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// NetworkCard updated with theme support
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

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      elevation: isSelected ? 8 : 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isSelected ? Border.all(color: AppColor.secondary, width: 2) : null,
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.9),
                radius: 28,
                child: imageAsset != null
                    ? ClipOval(
                        child: Image.asset(
                          imageAsset!,
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Text(
                        imageEmoji ?? '',
                        style: const TextStyle(fontSize: 24),
                      ),
              ),
              const SizedBox(height: 12),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSelected ? AppColor.secondary : textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Input field using theme-aware colors
class CustomInputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomInputField({
    required this.label,
    required this.icon,
    this.keyboardType,
    this.controller,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fillColor = Theme.of(context).inputDecorationTheme.fillColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.white);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColor.secondary),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red[400]!, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red[400]!, width: 2),
        ),
      ),
    );
  }
}
