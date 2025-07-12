import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_topup/features/home/screens/history.dart';
import 'package:vtu_topup/features/more/moreScreen.dart';
import 'package:vtu_topup/features/more/notifications.dart';
import 'package:vtu_topup/features/paybills/paybills_screent.dart';
import 'package:vtu_topup/features/profile/profile.dart';
import 'package:vtu_topup/features/task/taskScreen.dart';
import 'package:vtu_topup/features/topup/screens/airtime.dart';
import 'package:vtu_topup/features/topup/screens/cableScreen.dart';
import 'package:vtu_topup/features/topup/screens/data_topup_screen.dart';
import 'package:vtu_topup/features/topup/screens/electricity.dart';
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
    // Get screen size for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: color.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color.surface,
        iconTheme: IconThemeData(color: color.onSurface),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.pink[100],
            radius: 20, // Slightly reduced for better proportion
            child: TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
              child: Text(
                'D',
                style: GoogleFonts.poppins(
                  fontSize: 18, // Reduced font size for better fit
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
            ),
          ),
          title: Text(
            'Hello Daniel',
            style: GoogleFonts.poppins(
              fontSize: 18, // Slightly smaller for balance
              fontWeight: FontWeight.w600,
              color: color.onSurface,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined, size: 24), // Consistent icon size
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Slightly smaller radius
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: screenHeight * 0.22, // Responsive height (22% of screen height)
                padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
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
                            fontSize: screenWidth * 0.04, // Responsive font size
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                          },
                          child: Text(
                            'View History',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₦1,000',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: screenWidth * 0.07, // Responsive balance font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: screenHeight * 0.06, // Responsive button height
                        width: screenWidth * 0.35, // Responsive button width
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Colors.yellowAccent, Colors.orange]),
                          borderRadius: BorderRadius.circular(16), // Consistent radius
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()));
                              },
                              child: Text(
                                '+ Add Fund',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.04,
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
            SizedBox(height: screenHeight * 0.03), // Responsive spacing
            Text(
              'Quick Actions',
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: color.onSurface,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: screenWidth * 0.02, // Responsive spacing
              mainAxisSpacing: screenHeight * 0.015,
              childAspectRatio: 0.85, // Adjusted for better proportion
              children: [
                _quickAction(context, Icons.phone_android, 'Airtime', const AirtimeTopupScreen(), Colors.blue),
                _quickAction(context, Icons.wifi, 'Data', const DataTopupScreen(), Colors.green),
                _quickAction(context, Icons.tv, 'Cable', const CableTVRechargeScreen(), Colors.red),
                _quickAction(context, Icons.lightbulb, 'Electricity', const ElectricityTokenScreen(), Colors.orange),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: color.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewMoreScreen()));
                  },
                  child: Text(
                    'View more',
                    style: GoogleFonts.poppins(
                      color: color.onSurface.withOpacity(0.7),
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Card(
              color: theme.cardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MTN Data Subscription',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: color.onSurface,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Completed',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'Jul 5, 2025',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.03,
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
                            fontSize: screenWidth * 0.035,
                            color: color.onSurface.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          '₦500',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: color.onSurface,
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
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.04), // Responsive padding
        decoration: BoxDecoration(
          color: color.surface,
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
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
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
            child: Icon(icon, color: iconColor, size: screenWidth * 0.08), // Responsive icon size
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _navButton(BuildContext context, IconData icon, String label, Widget screen, int index) {
    final isSelected = _selectedNavIndex == index;
    final color = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedNavIndex = index);
        if (screen != const HomeScreen()) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: screenWidth * 0.02), // Responsive padding
        decoration: BoxDecoration(
          color: isSelected ? color.primaryContainer.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? color.primary : color.onSurface, size: screenWidth * 0.06), // Responsive icon size
            SizedBox(height: screenWidth * 0.01),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.03,
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