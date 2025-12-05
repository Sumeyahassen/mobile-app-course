// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Listen to login/logout changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // REGISTER
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    } catch (e) {
      throw "Registration failed. Please try again.";
    }
  }

  // LOGIN
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    } catch (e) {
      throw "Invalid email or password.";
    }
  }

  // LOGOUT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Convert Firebase errors to nice messages
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
      default:
        return e.message ?? 'Something went wrong';
    }
  }
}