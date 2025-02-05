import 'package:fiap_hackathon/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LoginProvider _loginProvider;

  @override
  void initState() {
    _loginProvider = Provider.of(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
            'Olá,${_loginProvider.isProfessor ? ' Prof.' : ''} ${_loginProvider.user!.displayName}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: () {},
              child: const Text('Verificar gráfico de alunos'),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text('Inserir contéudo'),
            ),
          ],
        ),
      ),
    );
  }
}
