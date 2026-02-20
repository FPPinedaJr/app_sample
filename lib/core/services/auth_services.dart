import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Firestore is initialized but not used in login yet, keeping it as requested
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User logged in successfully with UID: ${result.user!.uid}");
      return true;
    } catch (e) {
      print("Error during login: $e");
      return false;
    }
  }
}
