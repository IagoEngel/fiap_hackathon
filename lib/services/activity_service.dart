import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityService {
  static final database = FirebaseFirestore.instance;

  Future createActivity(Map<String, dynamic> json) async {
    await database.collection('atividades').add(json);
  }

  Future getActivities() async {
    final collection = await database.collection('atividades').get();
    for (var doc in collection.docs) {
      final docMap = doc.data();
    }
  }
}