import 'package:fiap_hackathon/providers/login_provider.dart';
import 'package:fiap_hackathon/utils/widgets/custom_filled_button_widget.dart';
import 'package:fiap_hackathon/utils/widgets/labeled_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _displayNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _isProfessor = false;

  @override
  void initState() {
    _displayNameController = TextEditingController(text: 'Iago Teste');
    _emailController = TextEditingController(text: 'iagoengelteste@yahoo.com');
    _passwordController = TextEditingController(text: 'Teste@123');
    _confirmPasswordController = TextEditingController(text: 'Teste@123');

    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua conta!'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top -
              AppBar().preferredSize.height,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                LabeledTextFieldWidget(
                  controller: _displayNameController,
                  label: 'Nome Completo',
                ),
                const SizedBox(height: 12),
                LabeledTextFieldWidget(
                  controller: _emailController,
                  label: 'E-mail',
                ),
                const SizedBox(height: 12),
                LabeledTextFieldWidget(
                  controller: _passwordController,
                  label: 'Senha',
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                LabeledTextFieldWidget(
                  controller: _confirmPasswordController,
                  label: 'Confirme sua senha',
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  onChanged: (value) =>
                      setState(() => _isProfessor = value ?? false),
                  value: _isProfessor,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sou um professor'),
                ),
                const SizedBox(height: 32),
                CustomFilledButtonWidget(
                  onPressed: _register,
                  title: 'CADASTRAR',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _register() async {
    final LoginProvider loginProvider = Provider.of(context, listen: false);

    await loginProvider.createUser(_emailController.text,
        _passwordController.text, _displayNameController.text, _isProfessor);

    if (!mounted) return;

    if (loginProvider.hasError) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Ocorreu um erro'),
                content: Text(loginProvider.errorMessage),
              ));

      return;
    }

    Navigator.pushNamed(context, '/home');
  }
}
