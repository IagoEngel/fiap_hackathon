import 'package:fiap_hackathon/providers/login_provider.dart';
import 'package:fiap_hackathon/screens/home/professor_content_widget.dart';
import 'package:fiap_hackathon/screens/home/student_content_widget.dart';
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
        child: _loginProvider.isProfessor
            ? ProfessorContentWidget(
                professorDocumentReference:
                    _loginProvider.professorDocumentReference)
            : const StudentContentWidget(),
      ),
    );
  }
}
