import 'package:fiap_hackathon/model/activity_model.dart';
import 'package:fiap_hackathon/providers/activity_provider.dart';
import 'package:fiap_hackathon/screens/home/widgets/alternative_widget.dart';
import 'package:fiap_hackathon/utils/widgets/custom_filled_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityItemWidget extends StatefulWidget {
  final ActivityModel activity;

  const ActivityItemWidget({
    super.key,
    required this.activity,
  });

  @override
  State<ActivityItemWidget> createState() => _ActivityItemWidgetState();
}

class _ActivityItemWidgetState extends State<ActivityItemWidget> {
  int selectedAlternative = 0;

  @override
  void initState() {
    selectedAlternative = widget.activity.alternativaSelecionada;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.grey[200],
      collapsedBackgroundColor: Colors.grey[300],
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      expandedAlignment: Alignment.centerLeft,
      title: Text(widget.activity.enunciado),
      children: [
        ..._buildAlternativeItems(),
        Visibility(
          visible: selectedAlternative != 0 && widget.activity.alternativaSelecionada == 0,
          child: CustomFilledButtonWidget(
            onPressed: () async {
              final ActivityProvider activityProvider =
                  Provider.of(context, listen: false);

              widget.activity.alternativaSelecionada = selectedAlternative;

              await activityProvider.confirmSelection(widget.activity);
            },
            title: 'Confirmar?',
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAlternativeItems() {
    final Map<int, String> alternatives = [
      widget.activity.alternativa1,
      widget.activity.alternativa2,
      widget.activity.alternativa3,
      widget.activity.alternativa4,
    ].asMap();

    return alternatives
        .map((i, title) {
          final index = i + 1;
          return MapEntry(
              index,
              AlternativeWidget(
                title: title,
                selected: selectedAlternative == index,
                onTap: () => setState(() => selectedAlternative =
                    index == selectedAlternative ? 0 : index),
              ));
        })
        .values
        .toList();
  }
}
