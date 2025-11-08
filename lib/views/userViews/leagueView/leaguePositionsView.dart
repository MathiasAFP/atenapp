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
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    // só busca uma vez
    _loadFuture = _initializeData();
  }

  Future<void> _initializeData() async {
    if (!_getCompetitorsExecuted) {
      await LeagueClassInstance.getCompetitorsLeague();
      _getCompetitorsExecuted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scaffold Padrão')),
      body: FutureBuilder(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // quando terminar de carregar, mostra os competidores
          return FutureBuilder(
            future: LeagueClassInstance.showCompetitorsList(),
            builder: (context, snapshot2) {
              if (snapshot2.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot2.hasError) {
                return Center(
                  child: Text(
                    'Erro ao carregar dados: ${snapshot2.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (snapshot2.hasData) {
                final data = snapshot2.data as List;
                if (data.isEmpty) {
                  return const Center(child: Text('Nenhum competidor encontrado.'));
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
              }

              return const Center(child: Text("Erro inesperado"));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () async {
          await LeagueClassInstance.getCompetitorsLeague();
          setState(() {}); // recarrega manualmente
        },
      ),
    );
  }
}
