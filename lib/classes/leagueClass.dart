import 'package:muto_system/connections/leagueConnection.dart';

class LeagueClass {
  List<dynamic> questionsList = [];

  Future<void> getCompetitorsLeague() async {
    questionsList = await getCompetitorsLeagueConnection();
  }

  Future<List> showCompetitorsList() async {
    return questionsList;
  }
}

  