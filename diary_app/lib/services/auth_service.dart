// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Save login info locally after successful online login
  Future<void> _saveLoginLocally(String email, String password) async {
    await _secureStorage.write(key: 'user_email', value: email.trim().toLowerCase());
    await _secureStorage.write(key: 'user_password', value: password);
    await _secureStorage.write(key: 'is_logged_in', value: 'true');
  }

  // Check if user has saved credentials
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

  // Clear saved login on logout
  Future<void> clearSavedLogin() async {
    await _secureStorage.delete(key: 'user_email');
    await _secureStorage.delete(key: 'user_password');
    await _secureStorage.delete(key: 'is_logged_in');
    await _secureStorage.delete(key: 'offline_logged_in');
  }

  // Register with email & password (online)
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Save credentials for offline use
      await _saveLoginLocally(email, password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  // Login with email & password (online)
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Save credentials for offline use
      await _saveLoginLocally(email, password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    }
  }

  // Offline login (no internet needed after first login)
  Future<bool> loginOffline() async {
    final creds = await getSavedCredentials();
    if (creds == null) return false;

    try {
      // Try online login first (if internet available)
      await _auth.signInWithEmailAndPassword(
        email: creds['email']!,
        password: creds['password']!,
      );
      return true;
    } catch (e) {
      // If no internet → allow offline access
      await _secureStorage.write(key: 'offline_logged_in', value: 'true');
      return true;
    }
  }

  // Check if user is logged in (online or offline)
  Future<bool> isLoggedIn() async {
    final firebaseUser = _auth.currentUser;
    final hasSaved = await hasSavedLogin();
    final offlineFlag = await _secureStorage.read(key: 'offline_logged_in') != null;

    return firebaseUser != null || hasSaved || offlineFlag;
  }

  // Logout – clear everything
  Future<void> signOut() async {
    await _auth.signOut();
    await clearSavedLogin();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Listen to auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Handle Firebase errors with user-friendly messages
  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password should be at least 6 characters';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'invalid-email':
        return 'Please enter a valid email address';
      case 'user-not-found':
      case 'wrong-password':
        return 'Invalid email or password';
      case 'too-many-requests':
        return 'Too many attempts. Try again later';
      case 'network-request-failed':
        return 'No internet connection';
      default:
        return e.message ?? 'An error occurred. Please try again.';
    }
  }
}