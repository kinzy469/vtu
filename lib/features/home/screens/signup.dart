import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_topup/apps/core/constant/app_color.dart';
import 'package:vtu_topup/features/home/screens/home_screen.dart';
import 'package:vtu_topup/features/home/screens/login.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Blue Container with Curved Bottom Corners
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: const BoxDecoration(
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Create An Account',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Form Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    // First Name
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Ex: Ahmed',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'dddd@gmail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.visibility_off),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // OR Divider
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Google Signup
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                        label: const Text('Sign up With Google'),
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Facebook Signup
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const FaIcon(
                          FontAwesomeIcons.facebookF,
                          size: 18,
                          color: Colors.blue,
                        ),
                        label: const Text('Sign up With Facebook'),
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bottom Text
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Login()),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
