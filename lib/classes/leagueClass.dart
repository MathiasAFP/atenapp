import 'package:Atena/connections/leagueConnection.dart';

class LeagueClass {
  List<dynamic> competitorsList = [];

  Future<void> getCompetitorsLeague() async {
    competitorsList = await getCompetitorsLeagueConnection();
  }

  Future<List<dynamic>> showCompetitorsList() async {
    return competitorsList;
  }
}

final LeagueClassInstance = LeagueClass();
