import 'package:flutter/material.dart';
import 'package:muto_system/classes/leagueClass.dart';
import 'package:muto_system/views/userViews/leagueView/questionView.dart';
import 'package:muto_system/views/widgets/competitorWidget.dart';

final LeagueClassInstance = LeagueClass();
bool _getCompetitorsExecuted = false;

class LeagueScreen extends StatefulWidget {
  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  void initState() {
    super.initState();
    if (!_getCompetitorsExecuted) {
      LeagueClassInstance.getCompetitorsLeague();
      _getCompetitorsExecuted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scaffold Padrão')),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: LeagueClassInstance.showCompetitorsList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text(
                    'Erro ao carregar dados: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  );
                }

                if (snapshot.hasData) {
                  final data = snapshot.data as List;
                  if (data.isEmpty) {
                    return const Text('Nenhum competidor encontrado.');
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final competitor = data[index] as Map<String, dynamic>;
                        return Competitor(
                          name: competitor['name'] ?? 'Sem nome',
                          points: competitor['points'] ?? 0,
                        );

                      },
                    ),
                  );
                }

                return const Text("Erro crítico");
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionScreen(
                      subject: "mat",
                      topic: "matbas",
                      subTopic: "matbasadi",
                      difficulty: 1,
                      searchType: "all",
                      howMany: 3,
                      context: "league",
                    ),
                  ),
                );
              },
              child: const Text("Fazer questões"),
            ),
          ],
        ),
      ),
    );
  }
}
