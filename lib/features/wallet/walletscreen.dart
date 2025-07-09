import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_topup/features/wallet/fundwallet.dart';
import 'package:vtu_topup/features/wallet/withraw.dart';

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
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Wallet",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WalletCard(balance: "₦1,500"),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Recent Transactions",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: transactions.isEmpty
                    ? const Center(child: Text("No transactions yet"))
                    : ListView.builder(
                        itemCount: transactions.length,
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Wallet Balance",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white70)),
          const SizedBox(height: 8),
          Text(
            balance,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Fundwallet()));
                },
                icon: const Icon(Icons.add),
                label: const Text("Fund Wallet"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => WithdrawScreen()));
                },
                icon: const Icon(Icons.arrow_downward),
                label: const Text("Withdraw"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
              ),
            ],
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
    final Color cardColor =
        isDark ? Colors.grey[850]! : Colors.grey[100]!;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: transaction.isDebit
              ? Colors.red[100]
              : Colors.green[100],
          child: Icon(
            transaction.isDebit ? Icons.arrow_upward : Icons.arrow_downward,
            color: transaction.isDebit ? Colors.red : Colors.green,
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          transaction.date,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          transaction.amount,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: transaction.isDebit ? Colors.red : Colors.green,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
