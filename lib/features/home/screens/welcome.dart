import 'package:flutter/material.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';
import 'package:vtu_topup/features/home/screens/login.dart';
import 'package:vtu_topup/features/home/screens/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.textLight,
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: AppColor.textLight,
              title: const Text(
                'Hi Welcome',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.secondary,
                ),
              ),
              centerTitle: true,
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/onboarding/onboard3.jpg',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 40),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const Signup()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.secondary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(color: AppColor.secondary),
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
