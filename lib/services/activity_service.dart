import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityService {
  static final database = FirebaseFirestore.instance;

  Future createActivity(Map<String, dynamic> json) async {
    await database.collection('atividades').add(json);
  }

  Future confirmSelection(Map<String, dynamic> json) async {
    await database.collection('atividades-alunos').add(json);
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
      final data = element.data() as Map;

      final map = {
        'documentReference': element.reference,
        "professorReference": data['professorReference'],
        "enunciado": data['enunciado'],
        "alternativa1": data['alternativa1'],
        "alternativa2": data['alternativa2'],
        "alternativa3": data['alternativa3'],
        "alternativa4": data['alternativa4'],
        "alternativaCorreta": data['alternativaCorreta'],
        "dataCriacao": data['dataCriacao'],
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

  Future<List<Map<String, dynamic>>> getActivitiesAsProfessor(
      DocumentReference professorReference) async {
    final List<Map<String, dynamic>> returnList = [];

    Query queryAlunos = database.collection('alunos');
    Query queryAtividades = database
        .collection('atividades')
        .where('professorReference', isEqualTo: professorReference);
    Query queryAtividadesAlunos = database
        .collection('atividades-alunos')
        .where('professorReference', isEqualTo: professorReference);

    final qtdAlunos = (await queryAlunos.get()).docs.length;

    final activitiesDocs = await queryAtividades.get();
    for (var element in activitiesDocs.docs) {
      final data = element.data() as Map;

      final map = {
        'qtdAlunos': qtdAlunos,
        "enunciado": data['enunciado'],
        "alternativa1": data['alternativa1'],
        "qtdAlternativa1": 0,
        "alternativa2": data['alternativa2'],
        "qtdAlternativa2": 0,
        "alternativa3": data['alternativa3'],
        "qtdAlternativa3": 0,
        "alternativa4": data['alternativa4'],
        "qtdAlternativa4": 0,
        "alternativaCorreta": data['alternativaCorreta'],
        "dataCriacao": data['dataCriacao'],
      };

      final atividadeAlunoDocs = await queryAtividadesAlunos
          .where('documentReference', isEqualTo: element.reference)
          .get();

      for (var atvAluno in atividadeAlunoDocs.docs) {
        final atvAlunoData = atvAluno.data() as Map;

        switch (atvAlunoData['alternativaSelecionada']) {
          case 1:
            map['qtdAlternativa1'] += 1;
            break;
          case 2:
            map['qtdAlternativa2'] += 1;
            break;
          case 3:
            map['qtdAlternativa3'] += 1;
            break;
          case 4:
            map['qtdAlternativa4'] += 1;
            break;
        }
      }

      returnList.add(map);
    }

    return returnList;
  }
}
