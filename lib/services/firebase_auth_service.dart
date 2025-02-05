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

  Future createUser(String email, String password, String displayName) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(displayName);

      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      rethrow;
    }
  }
}
