import 'package:flutter/material.dart';
import '../../../connections/credentialConnection.dart';
import '../../../classes/questionClass.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Responda")),
      body: Center(
        child: FutureBuilder<dynamic>(
          
          future: QuestionClass().takeSaveQuestionDataFunction("mat", "matbas", "matbasadi", 2, "all", 3),//isso deve ser passado pelo botão por context pra variáveis que devem estar no começo do arquivo 
          
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text(
                'Erro ao carregar questão',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }

            if (snapshot.hasData) {
              final userEmail = snapshot.data!;
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "E-mail do Usuário:",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userEmail, // O e-mail retornado pela API
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }

            return const Text('Nenhum dado encontrado.');
          },
        ),
      ),
    );
  }
}

//aqui que vai toda a lógica da página de questão