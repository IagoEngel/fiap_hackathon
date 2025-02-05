import 'package:fiap_hackathon/utils/widgets/labeled_text_field_widget.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _enunciadoAtividade = TextEditingController();
    _alternativa1 = TextEditingController();
    _alternativa2 = TextEditingController();
    _alternativa3 = TextEditingController();
    _alternativa4 = TextEditingController();

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top -
                AppBar().preferredSize.height,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                LabeledTextFieldWidget(
                  controller: _enunciadoAtividade,
                  label: 'Enunciado atividade',
                ),
                const SizedBox(height: 32),
                _buildAtividades(),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAtividades() {
    int count = 0;

    final listaAtividades =
        [_alternativa1, _alternativa2, _alternativa3, _alternativa4]
            .map((controller) => Padding(
                  padding: EdgeInsets.only(bottom: ++count < 4 ? 20 : 0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Atividade $count',
                    ),
                  ),
                ))
            .toList();

    return Column(children: listaAtividades);
  }
}
