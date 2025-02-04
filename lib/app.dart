import 'package:fiap_hackathon/providers/login_provider.dart';
import 'package:fiap_hackathon/routes/app_routes.dart';
import 'package:fiap_hackathon/utils/decoration_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'FIAP Hackathon',
        theme: DecorationScheme.theme,
        locale: const Locale('pt', 'BR'),
        initialRoute: '/login',
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
