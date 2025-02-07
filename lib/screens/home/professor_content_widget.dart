import 'package:fiap_hackathon/providers/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessorContentWidget extends StatefulWidget {
  final String professorDocumentReference;

  const ProfessorContentWidget({
    super.key,
    required this.professorDocumentReference,
  });

  @override
  State<ProfessorContentWidget> createState() => _ProfessorContentWidgetState();
}

class _ProfessorContentWidgetState extends State<ProfessorContentWidget> {
  late ActivityProvider _activityProvider;

  @override
  void initState() {
    _activityProvider = Provider.of(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          onPressed: () => Navigator.pushNamed(context, '/activity-add'),
          child: const Text('Adicionar atividade'),
        ),
        FutureBuilder(
          future: _activityProvider
              .getActivities(widget.professorDocumentReference),
          builder: (context, snapshot) {
            return FilledButton(
              onPressed: () {},
              child: const Text('Verificar gráfico de alunos'),
            );
          },
        ),
      ],
    );
  }
}
