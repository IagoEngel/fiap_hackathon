import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiap_hackathon/providers/activity_provider.dart';
import 'package:fiap_hackathon/providers/login_provider.dart';
import 'package:fiap_hackathon/utils/widgets/labeled_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _enunciadoAtividade;
  late TextEditingController _alternativa1;
  late TextEditingController _alternativa2;
  late TextEditingController _alternativa3;
  late TextEditingController _alternativa4;

  int alternativaCorreta = 0;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _enunciadoAtividade = TextEditingController(text: 'João tinha 15 balas e deu 7 para seu amigo Pedro. Com quantas balas João ficou?');
    _alternativa1 = TextEditingController(text: '6');
    _alternativa2 = TextEditingController(text: '7');
    _alternativa3 = TextEditingController(text: '8');
    _alternativa4 = TextEditingController(text: '9');

    super.initState();
  }

  @override
  void dispose() {
    _enunciadoAtividade.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar atividade'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top -
              AppBar().preferredSize.height,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabeledTextFieldWidget(
                  controller: _enunciadoAtividade,
                  label: 'Enunciado atividade',
                  maxLines: 10,
                ),
                const SizedBox(height: 32),
                _buildActivities(),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: _createActivity,
                  child: const Text('ADICIONAR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivities() {
    Map<int, TextEditingController> activities =
        [_alternativa1, _alternativa2, _alternativa3, _alternativa4].asMap();

    final activitiesList = activities
        .map((i, controller) => MapEntry(
            ++i,
            Padding(
              padding: EdgeInsets.only(bottom: i < 4 ? 20 : 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Alternativa $i',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha este campo!';
                        }

                        return null;
                      },
                    ),
                  ),
                  Checkbox(
                    value: alternativaCorreta == i,
                    onChanged: (_) => setState(() => alternativaCorreta = i),
                  ),
                ],
              ),
            )))
        .values
        .toList();

    return Column(children: activitiesList);
  }

  Future _createActivity() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final LoginProvider loginProvider = Provider.of(context, listen: false);
    final ActivityProvider activityProvider =
        Provider.of(context, listen: false);

    Map<String, dynamic> activityJson = {
      'enunciado': _enunciadoAtividade.text,
      'alternativa1': _alternativa1.text,
      'alternativa2': _alternativa2.text,
      'alternativa3': _alternativa3.text,
      'alternativa4': _alternativa4.text,
      'alternativaCorreta': alternativaCorreta,
      'dataCriacao': Timestamp.now(),
      'professorReference': loginProvider.professorDocumentReference,
    };
    await activityProvider.createActivity(activityJson);
    await activityProvider.getActivitiesAsProfessor(loginProvider.professorDocumentReference!);

    if (!mounted) {
      return;
    }

    if (activityProvider.hasError) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Ocorreu um erro'),
                content: Text(activityProvider.errorMessage),
              ));

      return;
    }

    Navigator.pop(context);
  }
}
