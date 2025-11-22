import 'package:Atena/classes/championshipClass.dart';
import 'package:flutter/material.dart';

ChampionshipClass championshipClassInstance = ChampionshipClass();

class myChampionshipsViewScreen extends StatefulWidget {
  @override
  State<myChampionshipsViewScreen> createState() => _myChampionshipsViewScreenState();
}

class _myChampionshipsViewScreenState extends State<myChampionshipsViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: ElevatedButton(onPressed: (){championshipClassInstance.getChampionships();}, child: Text("Buscar"))));
  }
}