import 'package:Atena/connections/championshipConnection.dart';

class ChampionshipClass {
  
  Future<String> createChampionship(name, code) async {
    return await createChampionshipConnection(name, code);
  }

  Future<List<dynamic>> getChampionships() async {
    final yChamps = await getChampionshipsConnection();
    print(yChamps);
    return yChamps;
  }

}