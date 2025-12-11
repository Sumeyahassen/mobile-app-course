// lib/services/auth_service.dart (add these imports at top)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Save login info after successful Firebase login
  Future<void> _saveLoginLocally(String email, String password) async {
    await _secureStorage.write(key: 'user_email', value: email.trim().toLowerCase());
    await _secureStorage.write(key: 'user_password', value: password);
    await _secureStorage.write(key: 'is_logged_in', value: 'true');
  }

  // Check if user has saved login
  Future<bool> hasSavedLogin() async {
    final email = await _secureStorage.read(key: 'user_email');
    final password = await _secureStorage.read(key: 'user_password');
    return email != null && password != null;
  }

  // Get saved credentials
  Future<Map<String, String>?> getSavedCredentials() async {
    final email = await _secureStorage.read(key: 'user_email');
    final password = await _secureStorage.read(key: 'user_password');
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
  }

  // Clear saved login (on logout)
  Future<void> clearSavedLogin() async {
    await _secureStorage.delete(key: 'user_email');
    await _secureStorage.delete(key: 'user_password');
    await _secureStorage.delete(key: 'is_logged_in');
  }

  // UPDATED: Login with Firebase (online) → then save locally
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Save for offline use after success
      await _saveLoginLocally(email, password);
      return result.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // Same for register
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await _saveLoginLocally(email, password);
      return result.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // NEW: Offline Login (No Internet Needed!)
  Future<bool> loginOffline() async {
    final creds = await getSavedCredentials();
    if (creds == null) return false;

    try {
      // Try Firebase first (if internet exists)
      await _auth.signInWithEmailAndPassword(
        email: creds['email']!,
        password: creds['password']!,
      );
      return true;
    } catch (e) {
      // If internet is off → still allow access!
      await _secureStorage.write(key: 'offline_logged_in', value: 'true');
      return true;
    }
  }

  // Check if user is logged in (online OR offline)
  Future<bool> isLoggedIn() async {
    final firebaseUser = _auth.currentUser;
    final hasSaved = await hasSavedLogin();
    final offlineFlag = await _secureStorage.read(key: 'offline_logged_in') != null;

    return firebaseUser != null || hasSaved || offlineFlag == true;
  }

  // Logout – clear everything
  Future<void> signOut() async {
    await _auth.signOut();
    await clearSavedLogin();
    await _secureStorage.delete(key: 'offline_logged_in');
  // clear flag
  }
}