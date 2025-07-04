import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer'; // ✅ Use log() instead of print()

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user with email, password, and full name
  Future<User?> register(String email, String password, String fullName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e, stackTrace) {
      log("Registration error",
          error: e, stackTrace: stackTrace, name: "AuthService");
      return null;
    }
  }

  // Login user with email and password
  Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e, stackTrace) {
      log("Login error", error: e, stackTrace: stackTrace, name: "AuthService");
      return null;
    }
  }

  // Logout user
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ✅ Reset password method for "Forgot Password"
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e, stackTrace) {
      log("Reset password error",
          error: e, stackTrace: stackTrace, name: "AuthService");
    }
  }
}
