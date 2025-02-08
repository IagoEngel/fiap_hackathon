import 'package:fiap_hackathon/providers/login_provider.dart';
import 'package:fiap_hackathon/utils/widgets/custom_filled_button_widget.dart';
import 'package:fiap_hackathon/utils/widgets/custom_text_button_widget.dart';
import 'package:fiap_hackathon/utils/widgets/labeled_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginProvider _loginProvider;

  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool isLoading = false;

  @override
  void initState() {
    _loginProvider = Provider.of(context, listen: false);

    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController(text: 'iagoengelteste@yahoo.com');
    _passwordController = TextEditingController(text: 'Teste@123');
    // _emailController = TextEditingController(text: 'iagoengel2@yahoo.com');
    // _passwordController = TextEditingController(text: 'Teste@123');

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LabeledTextFieldWidget(
                    controller: _emailController,
                    label: 'E-mail',
                  ),
                  const SizedBox(height: 12),
                  LabeledTextFieldWidget(
                    controller: _passwordController,
                    label: 'Senha',
                    isPassword: true,
                  ),
                  const SizedBox(height: 32),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Visibility(
      visible: !isLoading,
      replacement: const Center(child: CircularProgressIndicator()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomFilledButtonWidget(onPressed: _login, title: 'ENTRAR'),
          const SizedBox(height: 4),
          CustomTextButtonWidget(
              onPressed: _register,
              title: 'Não tem conta? Faça seu cadastro aqui.'),
        ],
      ),
    );
  }

  Future _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => isLoading = true);
    await _loginProvider.login(_emailController.text, _passwordController.text);
    setState(() => isLoading = false);

    if (!mounted) return;

    if (_loginProvider.hasError) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Ocorreu um erro'),
                content: Text(_loginProvider.errorMessage),
              ));

      return;
    }

    Navigator.pushNamed(context, '/home');
  }

  void _register() {
    Navigator.pushNamed(context, '/register');
  }
}
