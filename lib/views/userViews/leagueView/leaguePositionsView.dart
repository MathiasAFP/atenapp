import 'package:flutter/material.dart';
import 'package:muto_system/classes/leagueClass.dart';
import 'package:muto_system/views/userViews/leagueView/filterQuestionsView.dart';
import 'package:muto_system/views/userViews/leagueView/questionView.dart';
import 'package:muto_system/views/widgets/competitorWidget.dart';

final LeagueClassInstance = LeagueClass();
bool _firstExecution = false;

class LeagueScreen extends StatefulWidget {
  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  bool _loading = true; // controla o carregamento

  @override
  void initState() {
    super.initState();
    _loadCompetitors(); // chama função async separada
  }

  Future<void> _loadCompetitors() async {
    // Só busca se ainda não foi feita a requisição
    if (_firstExecution == false) {
      await LeagueClassInstance.getCompetitorsLeague();
      _firstExecution = true;
    }
    // Atualiza o estado pra reconstruir a tela
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Liga')),
      body: FutureBuilder(
        future: LeagueClassInstance.showCompetitorsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar participantes"));
          }

          if (snapshot.hasData) {
            final data = snapshot.data as List;
            if (data.isEmpty) {
              return const Center(child: Text("Nenhum participante encontrado"));
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final competitor = data[index];
                return Competitor(
                  name: competitor['name'] ?? 'Sem nome',
                  points: competitor['points'] ?? 0,
                );
              },
            );
          } else {
            return const Center(child: Text("Erro inesperado"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen()));
      }),
    );
  }
}