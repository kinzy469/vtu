import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtu_topup/features/home/screens/home_screen.dart';
// ignore: unused_import
import 'package:vtu_topup/features/home/screens/onboarding.dart';
// ignore: unused_import
import 'package:vtu_topup/features/wallet/walletscreen.dart';
import 'package:vtu_topup/theme/theme.dart';
import 'theme/theme_notifier.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickTopUp',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
