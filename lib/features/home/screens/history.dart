import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstants {
  static const Color primaryColor = Color(0xFF1976D2);
  static const double padding = 16.0;
  static const double cardRadius = 12.0;
}

class Transaction {
  final String label;
  final double amount;
  final String date;
  final bool isDebit;

  const Transaction({
    required this.label,
    required this.amount,
    required this.date,
    required this.isDebit,
  });
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

final NumberFormat currencyFormatter = NumberFormat.currency(
  locale: 'en_NG',
  symbol: '₦',
  decimalDigits: 0,
);

class _HistoryScreenState extends State<HistoryScreen> {
  String? _filterType;

  static const List<Map<String, dynamic>> historyData = [
    {
      'title': 'Airtime History',
      'icon': Icons.phone_android,
      'transactions': [
        Transaction(label: 'MTN Recharge', amount: -500, date: 'June 28, 2025', isDebit: true),
        Transaction(label: 'GLO Recharge', amount: -200, date: 'June 27, 2025', isDebit: true),
      ],
    },
    {
      'title': 'Data History',
      'icon': Icons.wifi,
      'transactions': [
        Transaction(label: 'Airtel Data', amount: -1000, date: 'June 26, 2025', isDebit: true),
      ],
    },
    {
      'title': 'Electricity History',
      'icon': Icons.flash_on,
      'transactions': [
        Transaction(label: 'EKEDC Token', amount: -3500, date: 'June 25, 2025', isDebit: true),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredData = _filterType == null
        ? historyData
        : historyData.where((section) => section['title'] == _filterType).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: theme.iconTheme.color),
            onSelected: (value) {
              setState(() {
                _filterType = value == 'All' ? null : value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              ...historyData.map((section) => PopupMenuItem(
                    value: section['title'],
                    child: Text(section['title']),
                  )),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await Future.delayed(const Duration(seconds: 1)),
          child: filteredData.isEmpty
              ? const Center(child: Text('No transactions available'))
              : ListView.separated(
                  padding: const EdgeInsets.all(AppConstants.padding),
                  itemCount: filteredData.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final section = filteredData[index];
                    return HistorySection(
                      title: section['title'],
                      icon: section['icon'],
                      transactions: section['transactions'],
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class HistorySection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Transaction> transactions;

  const HistorySection({
    super.key,
    required this.title,
    required this.icon,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final textColor = theme.colorScheme.onSurface;
    final subtitleColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

    return Card(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppConstants.primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (transactions.isEmpty)
              Text('No transactions in this category', style: TextStyle(color: subtitleColor)),
            ...transactions.map((transaction) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor:
                          transaction.isDebit ? Colors.red[100] : Colors.green[100],
                      child: Icon(
                        transaction.isDebit ? Icons.arrow_upward : Icons.arrow_downward,
                        color: transaction.isDebit ? Colors.red : Colors.green,
                      ),
                    ),
                    title: Text(
                      transaction.label,
                      style: TextStyle(color: textColor),
                    ),
                    subtitle: Text(
                      transaction.date,
                      style: TextStyle(color: subtitleColor, fontSize: 12),
                    ),
                    trailing: Text(
                      currencyFormatter.format(transaction.amount),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: transaction.isDebit ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                  const Divider(height: 8),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
