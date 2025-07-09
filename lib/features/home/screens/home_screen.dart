import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_topup/features/home/screens/history.dart';
import 'package:vtu_topup/features/more/moreScreen.dart';
import 'package:vtu_topup/features/paybills/paybills_screent.dart';
import 'package:vtu_topup/features/profile/profile.dart';
import 'package:vtu_topup/features/task/taskScreen.dart';
import 'package:vtu_topup/features/topup/screens/airtime.dart';
import 'package:vtu_topup/features/topup/screens/data_topup_screen.dart';
import 'package:vtu_topup/features/wallet/walletscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color.background,
        iconTheme: IconThemeData(color: color.onBackground),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.pink[100],
            radius: 22,
            child: Text(
              'D',
              style: TextStyle(
                color: color.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          title: Text(
            'Hello Daniel',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: color.onBackground,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.nightlight_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Theme toggle coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 180,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Balance',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                          },
                          child: Text(
                            'View History',
                            style: GoogleFonts.poppins(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₦1,000',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Colors.yellowAccent, Colors.orange]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()));
                              },
                              child: Text(
                                '+ Add Fund',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Quick Actions',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              childAspectRatio: 0.8,
              children: [
                _quickAction(context, Icons.phone_android, 'Airtime', const AirtimeTopupScreen(), Colors.blue),
                _quickAction(context, Icons.wifi, 'Data', const DataTopupScreen(), Colors.green),
                _quickAction(context, Icons.tv, 'Cable', const PayBillsScreen(), Colors.red),
                _quickAction(context, Icons.lightbulb, 'Electricity', const PayBillsScreen(), Colors.orange),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color.onBackground,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewMoreScreen()));
                  },
                  child: Text(
                    'View more',
                    style: GoogleFonts.poppins(color: color.onSurface.withOpacity(0.7)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              color: theme.cardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MTN Data Subscription',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: color.onBackground,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Completed',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Jul 5, 2025',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: color.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Amount',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: color.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '₦500',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navButton(context, Icons.home, 'Home', const HomeScreen(), 0),
            _navButton(context, Icons.cached_rounded, 'Pay Bills', const PayBillsScreen(), 1),
            _navButton(context, Icons.task_alt, 'Task', const TaskScreen(), 2),
            _navButton(context, Icons.person_4_outlined, 'Profile', const ProfileScreen(), 3),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(BuildContext context, IconData icon, String label, Widget screen, Color iconColor) {
    // ignore: unused_local_variable
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }

  Widget _navButton(BuildContext context, IconData icon, String label, Widget screen, int index) {
    final isSelected = _selectedNavIndex == index;
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedNavIndex = index);
        if (screen != const HomeScreen()) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.primaryContainer.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? color.primary : color.onSurface, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isSelected ? color.primary : color.onSurface.withOpacity(0.7),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
