import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  static final database = FirebaseFirestore.instance;

  Future createProfessor(String email) async {
    await database.collection('professores').add({"email": email});
  }

  Future<String> getProfessor(String email) async {
    final collection = await database.collection('professores').get();
    for (var doc in collection.docs) {
      final docMap = doc.data();
      if (docMap['email'] == email) {
        return doc.id;
      }
    }

    return '';
  }
}
