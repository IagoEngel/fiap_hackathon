import 'package:fiap_hackathon/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  bool hasError = false;
  String errorMessage = '';

  Future login(String email, String password) async {
    try {
      hasError = false;

      final UserCredential userCredential =
          await _firebaseAuthService.login(email, password);
      _user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      hasError = true;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage =
              'Email ou senha incorretos. Verifique suas credenciais';
          break;
        default:
          errorMessage = 'Ocorreu um erro inesperado. Tente novamente!';
      }
    }
  }

  Future createUser(String email, String password) async {
    try {
      hasError = false;

      final UserCredential userCredential =
          await _firebaseAuthService.createUser(email, password);
      _user = userCredential.user;
    } catch (e) {
      hasError = true;
      errorMessage = 'Ocorreu um erro inesperado. Tente novamente!';
    }
  }
}
