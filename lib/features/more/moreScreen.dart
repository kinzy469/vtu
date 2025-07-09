import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';

class ViewMoreScreen extends StatefulWidget {
  const ViewMoreScreen({super.key});

  @override
  _ViewMoreScreenState createState() => _ViewMoreScreenState();
}

class _ViewMoreScreenState extends State<ViewMoreScreen> {
  String? _filterMonth;

  static const List<Transaction> transactions = [
    Transaction(
      label: 'Glo Airtime',
      amount: -200,
      date: 'Jul 5, 2025',
      isDebit: true,
      type: 'Airtime',
      status: 'Completed',
    ),
    Transaction(
      label: 'MTN Airtime',
      amount: -500,
      date: 'Jul 3, 2025',
      isDebit: true,
      type: 'Airtime',
      status: 'Failed',
    ),
    Transaction(
      label: 'Airtel 1GB',
      amount: -500,
      date: 'Jun 28, 2025',
      isDebit: true,
      type: 'Data',
      status: 'Completed',
    ),
    Transaction(
      label: 'DSTV Compact',
      amount: -7900,
      date: 'Jun 22, 2025',
      isDebit: true,
      type: 'Cable TV',
      status: 'Completed',
    ),
  ];

  static final _currencyFormatter = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 0,
  );
  static final _monthFormatter = DateFormat('MMMM yyyy');
  static final _dateFormatter = DateFormat('MMM d, yyyy');

  Map<String, List<Transaction>> _groupTransactionsByMonth() {
    final Map<String, List<Transaction>> grouped = {};
    for (var transaction in transactions) {
      final date = _dateFormatter.parse(transaction.date);
      final monthKey = _monthFormatter.format(date);
      grouped.putIfAbsent(monthKey, () => []).add(transaction);
    }

    grouped.forEach((key, transactions) {
      transactions.sort((a, b) =>
          _dateFormatter.parse(b.date).compareTo(_dateFormatter.parse(a.date)));
    });

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactions = _groupTransactionsByMonth();
    final filteredMonths = _filterMonth == null
        ? groupedTransactions.keys.toList()
        : groupedTransactions.keys.where((month) => month == _filterMonth).toList();

    filteredMonths.sort((a, b) => _monthFormatter.parse(b).compareTo(_monthFormatter.parse(a)));

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Theme(
      data: theme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(theme.textTheme),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'All Transactions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.primary,
          iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.filter_list, color: theme.colorScheme.onPrimary),
              tooltip: 'Filter by Month',
              onSelected: (value) {
                setState(() {
                  _filterMonth = value == 'All' ? null : value;
                });
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'All', child: Text('All Months')),
                ...groupedTransactions.keys.map((month) => PopupMenuItem(
                      value: month,
                      child: Text(month),
                    )),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: filteredMonths.isEmpty
                ? const Center(child: Text('No transactions available'))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredMonths.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final month = filteredMonths[index];
                      final transactions = groupedTransactions[month]!;
                      return _buildTransactionSection(context, month, transactions);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionSection(
    BuildContext context,
    String month,
    List<Transaction> transactions,
  ) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: theme.cardColor,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          month,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        children: transactions.map((t) => _transactionTile(context, t)).toList(),
      ),
    );
  }

  Widget _transactionTile(BuildContext context, Transaction transaction) {
    final theme = Theme.of(context);
    final statusColor = transaction.status == 'Completed'
        ? AppColor.success
        : transaction.status == 'Failed'
            ? AppColor.error
            : Colors.orange;

    final IconData typeIcon = transaction.type == 'Airtime'
        ? Icons.phone_android
        : transaction.type == 'Data'
            ? Icons.wifi
            : Icons.tv;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor:
            transaction.isDebit ? Colors.red[100] : Colors.green[100],
        child: Icon(
          typeIcon,
          color: theme.colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        transaction.label,
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        transaction.date,
        style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _currencyFormatter.format(transaction.amount),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: transaction.isDebit ? Colors.red : Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            transaction.status,
            style: theme.textTheme.bodySmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final String label;
  final double amount;
  final String date;
  final bool isDebit;
  final String type;
  final String status;

  const Transaction({
    required this.label,
    required this.amount,
    required this.date,
    required this.isDebit,
    required this.type,
    required this.status,
  });
}
