import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiap_hackathon/providers/activity_provider.dart';
import 'package:fiap_hackathon/screens/home/widgets/pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfessorContentWidget extends StatefulWidget {
  final DocumentReference professorDocumentReference;

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
        const SizedBox(height: 20),
        FutureBuilder(
          future: _activityProvider
              .getActivitiesAsProfessor(widget.professorDocumentReference),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: _activityProvider.activitiesProfessorList.length,
                itemBuilder: (context, index) => PieChartWidget(
                    activity: _activityProvider.activitiesProfessorList[index]));
          },
        ),
      ],
    );
  }
}
