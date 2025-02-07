class ActivityChartModel {
  final int qtdAlunos;
  final String enunciado;
  final String alternativa1;
  final String alternativa2;
  final String alternativa3;
  final String alternativa4;
  final int qtdAlternativa1;
  final int qtdAlternativa2;
  final int qtdAlternativa3;
  final int qtdAlternativa4;
  final int alternativaCorreta;

  ActivityChartModel.fromDocumentSnapshot(Map<String, dynamic> json)
      : qtdAlunos = json['qtdAlunos'],
        enunciado = json['enunciado'],
        alternativa1 = json['alternativa1'],
        alternativa2 = json['alternativa2'],
        alternativa3 = json['alternativa3'],
        alternativa4 = json['alternativa4'],
        qtdAlternativa1 = json['qtdAlternativa1'],
        qtdAlternativa2 = json['qtdAlternativa2'],
        qtdAlternativa3 = json['qtdAlternativa3'],
        qtdAlternativa4 = json['qtdAlternativa4'],
        alternativaCorreta = json['alternativaCorreta'];
}
