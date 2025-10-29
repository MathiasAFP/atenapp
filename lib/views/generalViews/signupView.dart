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
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: ok ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
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
      // Ajuste: enviando com as chaves certas do backend
      final String response = await signupCredentialConnection(
        name.text,
        email.text,
        password.text,
        school.text,
        code.text,
        // keys: const {"schoolName": "school", "yourCode": "code"},
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
    final theme = Theme.of(context);
    final textColor = Colors.black87;

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
                _buildTextField("Nome", name, textColor),
                const SizedBox(height: 12),
                _buildTextField("Email", email, textColor),
                const SizedBox(height: 12),
                _buildTextField("Senha", password, textColor, isPassword: true),
                const SizedBox(height: 12),
                _buildTextField("Nome da Escola (opcional)", school, textColor),
                const SizedBox(height: 12),
                _buildTextField("Código (opcional)", code, textColor),
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
                    style: TextStyle(color: textColor),
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

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    Color textColor, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: textColor.withOpacity(0.8)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
