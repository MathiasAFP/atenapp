import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/views/credentialViews/signupView.dart';
import 'package:muto_system/views/test/testeJwt.dart';
import 'package:muto_system/views/userViews/homeView/homeView.dart';
import 'package:muto_system/connections/credentialConnection.dart';

class CredentialViewLogin extends StatefulWidget {
  const CredentialViewLogin({super.key});

  @override
  State<CredentialViewLogin> createState() => _CredentialViewLoginState();
}

class _CredentialViewLoginState extends State<CredentialViewLogin> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedUserType = 'user';
  final List<String> userTypes = ['user', 'student', 'teacher', 'school'];

  void showSnack(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final name = nameController.text.trim();
    final password = passwordController.text;
    final userType = selectedUserType;

    if (name.isEmpty || password.isEmpty || userType == null) {
      showSnack(
        'Por favor, preencha todos os campos e selecione o tipo de usuário.',
        false,
      );
      return;
    }

    showSnack('Tentando logar...', true);
    FocusScope.of(context).unfocus();

    try {
      final dynamic response = await loginCredentialConnection(
        name,
        password,
        userType,
      );

      // Se sua connection retorna Map com 'success' e 'message', trate assim
      if (response is Map<String, dynamic>) {
        final bool success = response['success'] == true;
        final String message = (response['message'] is String)
            ? response['message'] as String
            : (success ? 'Sucesso no login' : 'Erro no login');

        if (success) {
          showSnack(message, true);
          final dynamic data = response['data'];
          final String token = (data is Map && data['token'] is String)
              ? data['token'] as String
              : 'TOKEN_FICTICIO';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView(token: token)),
          );
          return;
        } else {
          showSnack(message, false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserProfileScreen()),
          );
          return;
        }
      }

      // Se a connection retorna diretamente um token string ou outro formato, trate conforme necessário
      if (response is String && response.isNotEmpty) {
        // se for token puro
        final String token = response;
        showSnack('Login realizado', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeView(token: token)),
        );
        return;
      }

      showSnack('Resposta inválida do servidor', false);
    } catch (e) {
      showSnack('Erro ao conectar-se: ${e.toString()}', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ThemeColors.Colors.background_black,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/img/logoAtena.png", width: 150),
                  const SizedBox(height: 15),

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "NOME",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "SENHA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedUserType,
                        hint: const Text("Selecione o Tipo de Usuário"),
                        items: userTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedUserType = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Esqueceu a senha?",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.Colors.background_black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _login,
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  RichText(
                    text: TextSpan(
                      text: "Você não tem uma conta? ",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(
                          text: "Cadastre-se",
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
                                  builder: (context) => CredentialView(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
