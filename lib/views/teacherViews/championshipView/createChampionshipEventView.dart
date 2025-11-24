import 'package:Atena/classes/championshipClass.dart';
import 'package:Atena/views/teacherViews/championshipView/chooseFilteredQuestionsForBlockView.dart';
import 'package:flutter/material.dart';

ChampionshipClass championshipClassInstance = ChampionshipClass();

class CreateChampionshipEventViewScreen extends StatefulWidget {
  
  final int championshipId;

  const CreateChampionshipEventViewScreen({
    super.key,
    required this.championshipId,
  });
  
  @override
  State<CreateChampionshipEventViewScreen> createState() =>
      _CreateChampionshipEventViewScreenState();
}

class _CreateChampionshipEventViewScreenState
    extends State<CreateChampionshipEventViewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rodada")),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Text("Adicionar rodada"),
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){}, child: Text("Questões próprias")),
                      ElevatedButton(onPressed: (){}, child: Text("Questões do banco")),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final createdBlock = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChooseFilteredQuestionsForBlockViewScreen(),
                            ),
                          );

                          if (createdBlock != null) {
                            championshipClassInstance.notConfirmedFilteredQuestions.add(createdBlock);
                            setState(() {});
                          }
                        },
                        child: Text("Questões filtradas"),
                      ),
                      ElevatedButton(onPressed: (){}, child: Text("Lições")),
                    ],
                  )
                ],
              ),
            ),

            /// só mostra se tiver algo
            if (championshipClassInstance.notConfirmedFilteredQuestions.isNotEmpty)
              Text(
                championshipClassInstance.notConfirmedFilteredQuestions.toString(),
              ),

            FutureBuilder(
              future: championshipClassInstance.takeAndSaveChampionshipEvent(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  return Text("Rodada carregada");
                }

                return Text("Nenhuma rodada encontrada");
              },
            )
          ],
        ),
      ),
    );
  }
}
