// lib/screens/fingerprint_unlock_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../services/fingerprint_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class FingerprintUnlockScreen extends StatefulWidget {
  const FingerprintUnlockScreen({super.key});

  @override
  State<FingerprintUnlockScreen> createState() => _FingerprintUnlockScreenState();
}

class _FingerprintUnlockScreenState extends State<FingerprintUnlockScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final FingerprintService _fingerprintService = FingerprintService();
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();

    // Glowing pulse animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Auto start fingerprint scan after screen appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticate();
    });
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    setState(() => _isAuthenticating = true);

    bool success = await _fingerprintService.authenticate();

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text("Fingerprint not recognized. Try again."),
          backgroundColor: Colors.redAccent,
        ),
      );
      setState(() => _isAuthenticating = false);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF8FBFF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated glowing fingerprint icon
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withOpacity(0.15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: _animationController.value * 15,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.fingerprint,
                            size: 120,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 60),

                  Text(
                    "Scan your fingerprint",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Touch the fingerprint sensor to unlock your diary",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 100),

                  // Try again button (only show if failed)
                  if (!_isAuthenticating)
                    ElevatedButton.icon(
                      onPressed: _authenticate,
                      icon: const Icon(Icons.fingerprint),
                      label: const Text("Try Again"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),

                  const SizedBox(height: 30),

                  // Backup login button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child:const Text(
                      "Use Email & Password",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}