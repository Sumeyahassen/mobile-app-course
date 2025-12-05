import 'package:diary_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'fingerprint_unlock_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2)); // show logo 2 sec

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final biometricEnabled = prefs.getBool('biometric_enabled') ?? false;

    if (biometricEnabled) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FingerprintUnlockScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightBlue, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 70, backgroundColor: Colors.white, child: Icon(Icons.book, size: 80, color: AppColors.primary)),
              const SizedBox(height: 24),
              Text("Daily Diary", style: GoogleFonts.playfairDisplay(fontSize: 40, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}