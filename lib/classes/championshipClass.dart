import 'package:Atena/connections/championshipConnection.dart';

class ChampionshipClass {
  List<Map<String, dynamic>> yourChampionships = [];
  bool _isLoaded = false;

  Future<void> takeAndSaveYourChampionships({bool forceReload = false}) async {
    // Se já carregou E não forçarmos o recarregamento, retorna.
    if (_isLoaded && !forceReload) { 
      return;
    }

    yourChampionships = await getChampionships();
    _isLoaded = true;
  }
  
  Future<List<Map<String, dynamic>>> showYourChampionships() async {
    return yourChampionships;
  }
}