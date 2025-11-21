import 'package:Atena/classes/classClass.dart';
import 'package:flutter/material.dart';

class CreateClassViewScreen extends StatefulWidget {
  @override
  State<CreateClassViewScreen> createState() => _CreateClassViewScreenState();
}

class _CreateClassViewScreenState extends State<CreateClassViewScreen> {
  // Instância da classe de serviço
  final classClassInstance = ClassClass();

  // Controladores declarados dentro do State (Correto)
  TextEditingController name = TextEditingController();
  TextEditingController teacherCode = TextEditingController();
  TextEditingController studentCode = TextEditingController();

  Future<void> createNewClass() async {
    // Chama sua função existente
    var response = await classClassInstance.createClass(
      name.text,
      teacherCode.text,
      studentCode.text,
    );

    if (!mounted) return;

    // Exibe o resultado no Modal (Seguindo o padrão do seu código base)
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Text(
          response,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
    
    // Se quiser limpar os campos após o sucesso, descomente abaixo:
    // if (response.contains("sucesso")) { // Ajuste conforme a msg da sua API
    //   name.clear();
    //   teacherCode.clear();
    //   studentCode.clear();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Usa Center + SingleChildScrollView + Card igual ao seu modelo
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            color: cs.secondary,
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mantive o logo para preservar a identidade visual da tela base
                  Image.asset('assets/images/logoWithoutBackground.png', height: 120),
                  const SizedBox(height: 20),

                  buildField("Nome da turma", name, cs),
                  buildField("Código para professor", teacherCode, cs),
                  buildField("Código para aluno", studentCode, cs),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: createNewClass,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.tertiary,
                      foregroundColor: cs.secondary,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 6,
                    ),
                    child: const Text("Criar Turma"),
                  ),
                  // Removi os links de "Já tenho conta/Sou aluno" pois não fazem sentido aqui
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper idêntico ao do seu código base
  Widget buildField(String label, TextEditingController controller, ColorScheme cs, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: cs.primary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: cs.tertiary),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: cs.tertiary)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: cs.primary, width: 2)),
      ),
    );
  }
}