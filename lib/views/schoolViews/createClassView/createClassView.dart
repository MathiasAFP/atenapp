import 'package:Atena/classes/classClass.dart';
import 'package:flutter/material.dart';

TextEditingController name = TextEditingController();
TextEditingController teacherCode = TextEditingController();
TextEditingController studentCode = TextEditingController();

final ClassClassInstance = ClassClass();

class CreateClassViewScreen extends StatefulWidget{
  @override
  State<CreateClassViewScreen> createState() => _CreateClassViewScreenState();
}

class _CreateClassViewScreenState extends State<CreateClassViewScreen> {
  @override
  Widget build(BuildContext context) {

    Future<void> saveResponse() async {
      var response = await ClassClassInstance.createClass(name.text, teacherCode.text, studentCode.text);

      if (response.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: Text(response),
        ),
      );
    }
  }  

    return Scaffold(body: Center(child: Column(children: [
      TextField(controller: name, decoration: InputDecoration(label: Text("Nome da turma"))),
      TextField(controller: teacherCode, decoration: InputDecoration(label: Text("Código para professor"))),
      TextField(controller: studentCode, decoration: InputDecoration(label: Text("Código para aluno"))),
      ElevatedButton(onPressed: (){saveResponse();}, child: Text("Criar")),
      
    ])));
  }
}