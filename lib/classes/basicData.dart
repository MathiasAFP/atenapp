import 'package:muto_system/connections/leagueConnection.dart';

class QuestionClass {
  List<dynamic> questionsList = [];

  Future<List> getCompetitorsLeague() async {
    
    final List questionsData = await getCompetitorsLeagueConnection();
    return [];
  }
}