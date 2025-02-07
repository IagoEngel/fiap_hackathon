import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final DocumentReference documentReference;
  final DocumentReference professorReference;
  final String enunciado;
  final String alternativa1;
  final String alternativa2;
  final String alternativa3;
  final String alternativa4;
  int alternativaSelecionada;

  ActivityModel.fromDocumentSnapshot(Map<String, dynamic> json)
      : documentReference = json['documentReference'],
        professorReference = json['professorReference'],
        enunciado = json['enunciado'],
        alternativa1 = json['alternativa1'],
        alternativa2 = json['alternativa2'],
        alternativa3 = json['alternativa3'],
        alternativa4 = json['alternativa4'],
        alternativaSelecionada = json['alternativaSelecionada'] ?? 0;

  Map<String, dynamic> toJson() => {
        'documentReference': documentReference,
        'professorReference': professorReference,
        'enunciado': enunciado,
        'alternativa1': alternativa1,
        'alternativa2': alternativa2,
        'alternativa3': alternativa3,
        'alternativa4': alternativa4,
        'alternativaSelecionada': alternativaSelecionada
      };

  Map<String, dynamic> toConfirmSelectionJson() => {
        'documentReference': documentReference,
        'professorReference': professorReference,
        'alternativaSelecionada': alternativaSelecionada
      };
}
