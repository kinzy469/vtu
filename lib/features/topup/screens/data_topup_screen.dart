import 'package:flutter/material.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';

class DataTopupScreen extends StatefulWidget {
  const DataTopupScreen({super.key});

  @override
  _DataTopupScreenState createState() => _DataTopupScreenState();
}

class _DataTopupScreenState extends State<DataTopupScreen> {
  String? selectedNetwork;
  String? selectedPlan;
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> dataPlans = [
    {'plan': '500MB - ₦200', 'value': '500MB'},
    {'plan': '1GB - ₦350', 'value': '1GB'},
    {'plan': '2GB - ₦600', 'value': '2GB'},
    {'plan': '5GB - ₦1400', 'value': '5GB'},
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Buy Data",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.secondary,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.secondary,
                AppColor.secondary.withOpacity(0.8)
              ],
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),
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
                    imageAsset: 'assets/airtime_logo/Glo_logo.jpeg',
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Select Data Plan",
                          prefixIcon: const Icon(Icons.data_usage),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor ?? cardColor,
                        ),
                        value: selectedPlan,
                        items: dataPlans.map((plan) {
                          return DropdownMenuItem<String>(
                            value: plan['value'],
                            child: Text(plan['plan']!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPlan = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a data plan' : null,
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
                    shadowColor: AppColor.secondary.withOpacity(0.4),
                  ),
                  onPressed: selectedNetwork == null || selectedPlan == null
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Purchasing $selectedPlan for $selectedNetwork',
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
                    "Buy Data",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
    final theme = Theme.of(context);
    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(16),
      elevation: isSelected ? 8 : 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isSelected
                ? Border.all(color: AppColor.secondary, width: 2)
                : null,
          ),
          child: Padding(
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
                    color: isSelected
                        ? AppColor.secondary
                        : theme.textTheme.bodyLarge?.color,
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
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColor.secondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
      ),
      validator: validator,
    );
  }
}
