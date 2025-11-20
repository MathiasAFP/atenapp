import 'package:Atena/views/widgets/championshipCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:Atena/classes/championshipClass.dart';

ChampionshipClass championshipClassInstance = ChampionshipClass();

class MyChampionshipsViewScreen extends StatefulWidget {
  const MyChampionshipsViewScreen({super.key});
  
  @override
  State<MyChampionshipsViewScreen> createState() => _MyChampionshipsViewScreenState();
}

class _MyChampionshipsViewScreenState extends State<MyChampionshipsViewScreen> {
  late Future<void> _initialLoadingFuture;

  @override
  void initState(){
    super.initState();
    _initialLoadingFuture = championshipClassInstance.takeAndSaveYourChampionships();
  }

  void _reloadChampionships() {
    setState(() {
      _initialLoadingFuture = championshipClassInstance.takeAndSaveYourChampionships(forceReload: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Campeonatos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadChampionships,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initialLoadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (championshipClassInstance.yourChampionships.isNotEmpty) { 
            return ListView.builder(
              itemCount: championshipClassInstance.yourChampionships.length,
              itemBuilder: (context, index) {
                return ChampionshipCardWidget(
                  name: championshipClassInstance.yourChampionships[index]["name"] as String
                );
              },
            );
          }

          else{
            return const Center(child: Text("Nenhum dado encontrado ou Erro inesperado"));
          }
        },
      ),
    );
  }
}