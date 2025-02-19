import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiap_hackathon/services/firebase_auth_service.dart';
import 'package:fiap_hackathon/services/firebase_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

  User? _user;
  User? get user => _user;

  bool isProfessor = false;
  DocumentReference? professorDocumentReference;

  bool hasError = false;
  String errorMessage = '';

  Future login(String email, String password) async {
    try {
      hasError = false;

      final UserCredential userCredential =
          await _firebaseAuthService.login(email, password);

      _user = userCredential.user;

      final DocumentReference? docRef = await _firebaseFirestoreService.getProfessor(email);

      isProfessor = docRef != null;
      professorDocumentReference = docRef;
    } on FirebaseAuthException catch (e) {
      debugPrint('getActivities ERROR ==> $e');

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

  Future createUser(
      String email, String password, String displayName, bool professor) async {
    try {
      hasError = false;

      _user =
          await _firebaseAuthService.createUser(email, password, displayName);

      isProfessor = professor;

      await _firebaseFirestoreService.createProfessor(
          isProfessor ? 'professores' : 'alunos', email, displayName);
    } catch (e) {
      hasError = true;
      errorMessage = 'Ocorreu um erro inesperado. Tente novamente!';
    }
  }
}
