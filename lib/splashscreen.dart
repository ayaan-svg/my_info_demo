// lib/splashscreen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_info_demo/main.dart'; // Import the main.dart file

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Method to handle navigation after a delay
  _navigateToHome() async {
    // Wait for 3 seconds before navigating
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the MainScreen and replace the splash screen route
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hide the system status and navigation bars for a full-screen splash experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use your app's logo or a simple text.
            // Replace with your image asset if you have one.
            Image(
              image: AssetImage(
                'assets/logo.png',
              ), // Replace with your logo path
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF07E2E)),
            ),
            SizedBox(height: 10),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Restore the system status and navigation bars when the splash screen is disposed
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }
}
