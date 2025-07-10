import 'package:flutter/material.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';

class CableTVRechargeScreen extends StatefulWidget {
  const CableTVRechargeScreen({super.key});

  @override
  _CableTVRechargeScreenState createState() => _CableTVRechargeScreenState();
}

class _CableTVRechargeScreenState extends State<CableTVRechargeScreen> {
  String? selectedProvider;
  final _subscriberIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<double> get predefinedAmounts {
    return ["Netflix", "Prime Video", "Showmax", "IrokoTV", "KDNPLUS"].contains(selectedProvider)
        ? [1200, 2000, 2900, 5000, 10000] // Adjusted for streaming services
        : [1000, 2000, 5000, 10000, 15000]; // Default for cable TV
  }

  @override
  void dispose() {
    _subscriberIdController.dispose();
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Cable TV & Streaming Recharge",
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
        padding: const EdgeInsets.all(16.0),
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
                    ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  NetworkCard(
                    name: "DStv",
                    color: Colors.blue[700]!,
                    imageAsset: 'assets/provider_logo/dstv_logo.png',
                    isSelected: selectedProvider == "DStv",
                    onTap: () => setState(() => selectedProvider = "DStv"),
                  ),
                  NetworkCard(
                    name: "GOtv",
                    color: Colors.red[700]!,
                    imageAsset: 'assets/images/tvlogo/gotv.png',
                    isSelected: selectedProvider == "GOtv",
                    onTap: () => setState(() => selectedProvider = "GOtv"),
                  ),
                  NetworkCard(
                    name: "Startimes",
                    color: Colors.purple[700]!,
                    imageAsset: 'assets/provider_logo/startimes_logo.jpeg',
                    isSelected: selectedProvider == "Startimes",
                    onTap: () => setState(() => selectedProvider = "Startimes"),
                  ),
                  NetworkCard(
                    name: "Netflix",
                    color: Colors.red[900]!,
                    imageAsset: 'assets/provider_logo/netflix_logo.png',
                    isSelected: selectedProvider == "Netflix",
                    onTap: () => setState(() => selectedProvider = "Netflix"),
                  ),
                  NetworkCard(
                    name: "Prime Video",
                    color: Colors.blue[900]!,
                    imageAsset: 'assets/provider_logo/primevideo_logo.png',
                    isSelected: selectedProvider == "Prime Video",
                    onTap: () => setState(() => selectedProvider = "Prime Video"),
                  ),
                  NetworkCard(
                    name: "Showmax",
                    color: Colors.black87,
                    imageAsset: 'assets/provider_logo/showmax_logo.png',
                    isSelected: selectedProvider == "Showmax",
                    onTap: () => setState(() => selectedProvider = "Showmax"),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInputField(
                        label: "Subscriber ID / Email",
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        controller: _subscriberIdController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a subscriber ID or email';
                          }
                          if (["Netflix", "Prime Video", "Showmax", "IrokoTV", "KDNPLUS"].contains(selectedProvider)) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                          } else {
                            if (!RegExp(r'^\d{8,12}$').hasMatch(value)) {
                              return 'Enter a valid subscriber ID';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
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
                          if (amount < 500) {
                            return 'Minimum amount is ₦500';
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

              const SizedBox(height: 24),
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
                  onPressed: selectedProvider == null || _amountController.text.isEmpty
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            final action = ["Netflix", "Prime Video", "Showmax", "IrokoTV", "KDNPLUS"].contains(selectedProvider)
                                ? "Subscribing to"
                                : "Recharging";
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '$action ₦${_amountController.text} for $selectedProvider',
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
                    "Recharge Now",
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

// NetworkCard with adjusted size for better responsiveness
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

    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 - 24, // Responsive width
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        elevation: isSelected ? 6 : 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: isSelected ? Border.all(color: AppColor.secondary, width: 2) : null,
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.9),
                  radius: 24,
                  child: imageAsset != null
                      ? ClipOval(
                          child: Image.asset(
                            imageAsset!,
                            height: 36,
                            width: 36,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Text(
                          imageEmoji ?? '',
                          style: const TextStyle(fontSize: 20),
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isSelected ? AppColor.secondary : textColor,
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

// Reusing CustomInputField from the reference
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
        (Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white);

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