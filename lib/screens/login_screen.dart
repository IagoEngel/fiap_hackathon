import 'package:fiap_hackathon/utils/widgets/custom_filled_button_widget.dart';
import 'package:fiap_hackathon/utils/widgets/labeled_text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _senhaController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _senhaController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              LabeledTextFieldWidget(
                controller: _emailController,
                label: 'E-mail',
              ),
              const SizedBox(height: 12),
              LabeledTextFieldWidget(
                controller: _senhaController,
                label: 'Senha',
              ),
              const SizedBox(height: 32),
              CustomFilledButtonWidget(onPressed: _login, title: 'AAAAAA'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future _login() async {}
}
