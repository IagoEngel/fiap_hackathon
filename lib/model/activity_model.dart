import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final DocumentReference documentReference;
  final DocumentReference professorReference;
  final String enunciado;
  final String alternativa1;
  final String alternativa2;
  final String alternativa3;
  final String alternativa4;
  final int alternativaCorreta;
  final Timestamp dataCriacao;
  int alternativaSelecionada;

  ActivityModel.fromDocumentSnapshot(Map<String, dynamic> json)
      : documentReference = json['documentReference'],
        professorReference = json['professorReference'],
        enunciado = json['enunciado'],
        alternativa1 = json['alternativa1'],
        alternativa2 = json['alternativa2'],
        alternativa3 = json['alternativa3'],
        alternativa4 = json['alternativa4'],
        alternativaCorreta = json['alternativaCorreta'],
        dataCriacao = json['dataCriacao'],
        alternativaSelecionada = json['alternativaSelecionada'] ?? 0;

  Map<String, dynamic> toConfirmSelectionJson() => {
        'documentReference': documentReference,
        'professorReference': professorReference,
        'alternativaSelecionada': alternativaSelecionada
      };
}
