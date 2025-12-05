// lib/services/fingerprint_service.dart
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FingerprintService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometric_enabled') ?? false;
  }

  Future<void> setBiometricEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_enabled', value);
  }

  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Unlock your diary with fingerprint',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }

  Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }
}