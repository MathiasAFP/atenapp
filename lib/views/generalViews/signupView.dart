import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/connections/credentialConnection.dart';
import 'package:muto_system/views/generalViews/loginView.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/views/generalViews/schoolSignupView.dart';

class CredentialView extends StatefulWidget {
  const CredentialView({super.key});

  @override
  State<CredentialView> createState() => _CredentialViewState();
}

class _CredentialViewState extends State<CredentialView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  bool isLoading = false;

  void showSnack(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    schoolNameController.dispose();
    codeController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final schoolName = schoolNameController.text.trim();
    final code = codeController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showSnack('Por favor preencha nome, email e senha.', false);
      return;
    }

    if (schoolName.isNotEmpty && code.isEmpty) {
      showSnack('Você precisa informar o código da escola.', false);
      return;
    }
    if (code.isNotEmpty && schoolName.isEmpty) {
      showSnack('Todo código tem uma escola. Informe o nome da escola.', false);
      return;
    }

    setState(() => isLoading = true);
    FocusScope.of(context).unfocus();

    try {
      final dynamic response = await signupCredentialConnection(
        name,
        email,
        password,
        schoolName,
        code,
      );

      if (response is Map && response['success'] == true) {
        showSnack(
          response['message'] is String
              ? response['message'] as String
              : 'Cadastro realizado com sucesso!',
          true,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CredentialViewLogin()),
        );
        return;
      }

      if (response is Map && response['message'] is String) {
        showSnack(response['message'] as String, false);
        return;
      }

      if (response is String) {
        showSnack(response, false);
        return;
      }

      showSnack('Algo deu errado', false);
    } catch (e) {
      showSnack('Erro inesperado: $e', false);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ThemeColors.Colors.background_black,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/img/logoAtena.png", width: 175),
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "NOME",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "EMAIL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "SENHA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: schoolNameController,
                    decoration: InputDecoration(
                      labelText: "NOME DA ESCOLA (opcional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: codeController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "SEU CÓDIGO (opcional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.Colors.background_black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: isLoading ? null : _handleSignup,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Cadastrar-se",
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: "Você já tem uma conta? ",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(
                          text: "Entre com ela",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CredentialViewLogin(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 12),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const schoolCredentialView(),
                  //       ),
                  //     );
                  //   },
                  //   child: const Text("Para instituições"),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
