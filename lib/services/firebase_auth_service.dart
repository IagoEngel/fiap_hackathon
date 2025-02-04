import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future login(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
