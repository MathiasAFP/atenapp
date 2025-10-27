import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/connections/credentialConnection.dart';
import 'package:muto_system/views/generalViews/loginView.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;

class CredentialView extends StatefulWidget {
  const CredentialView({super.key});

  @override
  State<CredentialView> createState() => _CredentialViewState();
}

class _CredentialViewState extends State<CredentialView> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final school = TextEditingController();
  final code = TextEditingController();

  bool isLoading = false;

  void showSnack(String msg, bool ok) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: ok ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _signup() async {
    if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
      showSnack("Preencha nome, email e senha", false);
      return;
    }

    setState(() => isLoading = true);
    FocusScope.of(context).unfocus();

    try {
      final String response = await signupCredentialConnection(
        name.text,
        email.text,
        password.text,
        school.text,
        code.text,
      );

      if (!mounted) return;
      setState(() => isLoading = false);

      final success =
          response.toLowerCase().contains('sucesso') ||
          response.toLowerCase().contains('cadastrado');

      showSnack(
        response.isNotEmpty ? response : 'Resposta do servidor',
        success,
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CredentialViewLogin()),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      showSnack("Erro: $e", false);
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    school.dispose();
    code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.Colors.background_black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Image.asset("assets/img/logoAtena.png", width: 150),
                const SizedBox(height: 20),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: "Nome"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Senha"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: school,
                  decoration: const InputDecoration(
                    labelText: "Nome da Escola (opcional)",
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: code,
                  decoration: const InputDecoration(
                    labelText: "Código (opcional)",
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.Colors.background_black,
                      foregroundColor: Colors.white,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Cadastrar",
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    text: "Já tem uma conta? ",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Entrar",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CredentialViewLogin(),
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
