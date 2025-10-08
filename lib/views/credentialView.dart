import 'package:flutter/material.dart';
import 'package:muto_system/views/testView.dart';
import '../connections/credentialConnection.dart';

class Credentialview extends StatefulWidget {
  @override
  State<Credentialview> createState() => _CredentialviewState();
}

class _CredentialviewState extends State<Credentialview> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cod = TextEditingController();

  void showSnack(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            TextField(
              controller: cod,
              decoration: InputDecoration(labelText: 'Código para SignUp'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (cod.text.isEmpty) {
                    final LoginAnswer = await Login(name.text, email.text, password.text, cod.text);
                    if (LoginAnswer == 200) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Credentialview()));
                      showSnack('Usuário cadastrado com sucesso!', true);
                    } else {
                      showSnack('Erro ao cadastrar usuário.', false);
                    }
                  } else {
                    final SignUpAnswer = await SignUp(name.text, email.text, password.text, cod.text);
                    if (SignUpAnswer == 200) {
                      showSnack('Aluno cadastrado com sucesso!', true);
                    } else {
                      showSnack('Erro ao cadastrar administrador.', false);
                    }
                  }
                } catch (e) {
                  showSnack('Erro inesperado: $e', false);
                }
              },
              child: Text("SignUp"),
            ),
          ],
        ),
      ),
    );
  }
}