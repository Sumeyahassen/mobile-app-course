// lib/screens/fingerprint_enable_screen.dart
import 'package:diary_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/fingerprint_service.dart';
import 'home_screen.dart';

class FingerprintEnableScreen extends StatelessWidget {
  const FingerprintEnableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FingerprintService();

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint, size: 120, color: AppColors.primary),
              const SizedBox(height: 40),
              Text("Enable Fingerprint?", style: GoogleFonts.playfairDisplay(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text("Use fingerprint to unlock your diary offline", textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () async {
                  await service.setBiometricEnabled(true);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                child: const Text("Enable", style: TextStyle(fontSize: 18)),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
                child: const Text("Skip", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}