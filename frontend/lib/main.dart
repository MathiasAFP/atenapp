import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/checklist_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ConfigClass(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigClass>(
      builder: (context, config, child) {
        return MaterialApp(
          title: 'Checklist de Viagem',
          debugShowCheckedModeBanner: false,
          theme: config.getThemeData(),
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
          },
          home: FutureBuilder<bool>(
            future: _checkLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasData && snapshot.data == true) {
                return const ChecklistPage();
              }
              return const LoginPage();
            },
          ),
        );
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }
}
