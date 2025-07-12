import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';
import 'package:vtu_topup/features/wallet/fundwallet.dart';

class Transaction {
  final String title;
  final String amount;
  final String date;
  final bool isDebit;

  const Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.isDebit,
  });
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  static const List<Transaction> transactions = [
    Transaction(
      title: "Airtime Top-up",
      amount: "- ₦500",
      date: "June 28, 2025",
      isDebit: true,
    ),
    Transaction(
      title: "Wallet Funded",
      amount: "+ ₦2,000",
      date: "June 27, 2025",
      isDebit: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Wallet",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Fundwallet()),
          );
        },
        backgroundColor: AppColor.primary,
        tooltip: 'Fund Wallet',
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WalletCard(balance: "₦1,500"),
              const SizedBox(height: 24),
              Text(
                "Recent Transactions",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: transactions.isEmpty
                    ? _EmptyState()
                    : ListView.separated(
                        itemCount: transactions.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return _TransactionTile(transaction: transactions[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  final String balance;

  const _WalletCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primary, AppColor.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Wallet Balance",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            balance,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Fundwallet()),
              );
            },
            icon: const Icon(Icons.add, size: 20),
            label: const Text(
              "Fund Wallet",
              style: TextStyle(fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColor.textDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDark ? Colors.grey[850]! : Colors.grey[100]!;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: transaction.isDebit ? Colors.red[100] : Colors.green[100],
          child: Icon(
            transaction.isDebit ? Icons.arrow_upward : Icons.arrow_downward,
            color: transaction.isDebit ? Colors.red : Colors.green,
            size: 24,
          ),
        ),
        title: Text(
          transaction.title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          transaction.date,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        trailing: Text(
          transaction.amount,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: transaction.isDebit ? Colors.red : Colors.green,
          ),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tapped on ${transaction.title}")),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.history_toggle_off,
          size: 64,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
        const SizedBox(height: 16),
        Text(
          "No transactions yet",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Fund your wallet to get started!",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}