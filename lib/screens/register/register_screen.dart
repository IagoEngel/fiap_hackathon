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
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'iagoengelteste@yahoo.com');
    _passwordController = TextEditingController(text: 'Teste@123');
    _confirmPasswordController = TextEditingController(text: 'Teste@123');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua conta!'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top -
                AppBar().preferredSize.height,
          ),
          child: Column(
            children: [
              const Spacer(),
              LabeledTextFieldWidget(
                controller: _emailController,
                label: 'E-mail',
              ),
              const SizedBox(height: 12),
              LabeledTextFieldWidget(
                controller: _passwordController,
                label: 'Senha',
              ),
              const SizedBox(height: 12),
              LabeledTextFieldWidget(
                controller: _confirmPasswordController,
                label: 'Confirme sua senha',
              ),
              CustomFilledButtonWidget(
                  onPressed: _register, title: 'CADASTRAR'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future _register() async {
    final LoginProvider loginProvider = Provider.of(context, listen: false);

    await loginProvider.createUser(
        _emailController.text, _passwordController.text);

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
