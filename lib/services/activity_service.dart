import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityService {
  static final database = FirebaseFirestore.instance;

  Future createActivity(Map<String, dynamic> json) async {
    await database.collection('atividades').add(json);
  }

  Future<List<Map<String, dynamic>>> getActivities(
      String professorReference) async {
    Query queryAtividades = database.collection('atividades');
    Query queryAtividadeAlunos = database.collection('atividades-alunos');

    if (professorReference.isNotEmpty) {
      queryAtividades = queryAtividades.where('professorReference',
          isEqualTo: professorReference);

      queryAtividadeAlunos = queryAtividadeAlunos.where('professorReference',
          isEqualTo: professorReference);
    }

    final activitiesDocs = await queryAtividades.get();

    final List<Map<String, dynamic>> returnList = [];

    for (var element in activitiesDocs.docs) {
      final map = {
        'documentReference': element.reference,
        "professorReference": (element.data()! as Map)['professorReference'],
        "enunciado": (element.data()! as Map)['enunciado'],
        "alternativa1": (element.data()! as Map)['alternativa1'],
        "alternativa2": (element.data()! as Map)['alternativa2'],
        "alternativa3": (element.data()! as Map)['alternativa3'],
        "alternativa4": (element.data()! as Map)['alternativa4']
      };

      final atividadeAlunoDocs = await queryAtividadeAlunos
          .where('documentReference', isEqualTo: element.reference)
          .get();

      if (atividadeAlunoDocs.docs.isNotEmpty) {
        map['alternativaSelecionada'] = (atividadeAlunoDocs.docs[0].data()
            as Map)['alternativaSelecionada'];
      }

      returnList.add(map);
    }

    return returnList;
  }

  Future confirmSelection(Map<String, dynamic> json) async {
    await database.collection('atividades-alunos').add(json);
  }
}
