import 'package:Atena/classes/championshipClass.dart';
import 'package:flutter/material.dart';

ChampionshipClass championshipClassInstance = ChampionshipClass();

class ChooseFilteredQuestionsForBlockViewScreen extends StatefulWidget {
  @override
  State<ChooseFilteredQuestionsForBlockViewScreen> createState() => _ChooseFilteredQuestionsForBlockViewScreenState();
}

class _ChooseFilteredQuestionsForBlockViewScreenState extends State<ChooseFilteredQuestionsForBlockViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Escolher questões filtradas")),
      body: FutureBuilder(future: championshipClassInstance.getContents("subject",""),  builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            final list = snapshot.data as List;
            return Column(
              children: list.map((e) => Text(e.toString())).toList(),
            );
          }

          return Text("Erro ao buscar questões");
    }
));
  }
}