import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  static final database = FirebaseFirestore.instance;

  Future createProfessor(
      String collectionName, String email, String displayName) async {
    await database
        .collection(collectionName)
        .add({"email": email, "displayName": displayName});
  }

  Future<DocumentReference?> getProfessor(String email) async {
    final collection = await database.collection('professores').get();
    for (var doc in collection.docs) {
      final docMap = doc.data();
      if (docMap['email'] == email) {
        return doc.reference;
      }
    }

    return null;
  }
}
