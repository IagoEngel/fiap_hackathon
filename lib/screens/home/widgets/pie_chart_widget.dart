import 'package:fiap_hackathon/model/activity_chart_model.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  final ActivityChartModel activity;

  const PieChartWidget({super.key, required this.activity});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Enunciado:\n${widget.activity.enunciado}'),
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _buildAlternativesColumns(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAlternativesColumns() {
    final list = {
      'A': {
        'alternative': widget.activity.alternativa1,
        'qtd': widget.activity.qtdAlternativa1.toDouble()
      },
      'B': {
        'alternative': widget.activity.alternativa2,
        'qtd': widget.activity.qtdAlternativa2.toDouble()
      },
      'C': {
        'alternative': widget.activity.alternativa3,
        'qtd': widget.activity.qtdAlternativa3.toDouble()
      },
      'D': {
        'alternative': widget.activity.alternativa4,
        'qtd': widget.activity.qtdAlternativa4.toDouble()
      },
    };

    final List<Widget> listWidgets = [];

    for (var element in list.entries) {
      double height =
          (100 * (element.value['qtd'] as double)) / widget.activity.qtdAlunos;

      listWidgets.add(Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if ((element.value['qtd'] as double) != 0)
            Text((element.value['qtd'] as double).toStringAsFixed(0)),
          Container(
            color: Colors.red,
            width: 20,
            height: height,
          ),
          Text(element.key),
        ],
      ));
    }

    return listWidgets;
  }
}
