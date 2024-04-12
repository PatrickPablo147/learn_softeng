import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> createUserWithEmailPassword(String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );

    await currentUser.user!.updateDisplayName(name);
    await currentUser.user!.reload();

    return currentUser.user?.uid ?? '';

  }

  // Email and Password Sign In
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!.uid;
  }

  // Sign out
  signOut() {
    return _firebaseAuth.signOut();
  }

  // Get UID
  Future<String> getCurrentUID() async {
    return await _firebaseAuth.currentUser!.uid;
  }

  Future<String?> getCurrentDisplayName() async {
    return await _firebaseAuth.currentUser!.displayName;
  }

}