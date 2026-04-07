import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> register(String name, String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = result.user;
      if (user == null) return null;

      await user.updateDisplayName(name.trim());

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      return user;
    } on FirebaseAuthException catch (e) {
      print("AUTH ERROR: ${e.code} - ${e.message}");
      return null;
    } on FirebaseException catch (e) {
      print("FIRESTORE ERROR: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("UNKNOWN ERROR: $e");
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      print("LOGIN ERROR: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("UNKNOWN LOGIN ERROR: $e");
      return null;
    }
  }
}