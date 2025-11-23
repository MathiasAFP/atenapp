import 'package:Atena/connections/championshipConnection.dart';

class ChampionshipClass {
  List yourChampionships = [];
  bool tascfirstExecution = true;
  bool tascefirstExecution = true;
  bool contentfirstExecution = true;
  List<String> subjects = [];
  List<String> topics = [];
  List<String> subtopics = [];
  
  Future<String> createChampionship(name, code) async {
    return await createChampionshipConnection(name, code);
  }

  Future<List> takeAndSaveChampionships() async {
    if (tascfirstExecution) {
      final yChamps = await getChampionshipsConnection();
      yourChampionships = yChamps;
      tascfirstExecution = false;
      return yourChampionships;
    }
    return yourChampionships;
  }

  Future<List> takeAndSaveChampionshipEvent() async {
    if (tascefirstExecution) {
      final yChamps = await getChampionshipsConnection();
      yourChampionships = yChamps;
      tascefirstExecution = false;
      return yourChampionships;
    }
    return yourChampionships;
  }

  void tascereloadState(){
    tascefirstExecution = true;
  }

  void tascreloadState(){
    tascfirstExecution = true;
  }

  Future<List> getContents(contentType, contentValue) async {
    print("contentType recebido = '$contentType'");
    if (contentType == "subject") {
      print("Entrou no if");
      final subjects = await getSubjectsForChampionshipBlockConnection();
      print(subjects);
      final correctSubjects = subjects.map((e) => e["subject"]).toList();
      print(correctSubjects);
      return correctSubjects;
    }
    else if(contentType == "topic"){
      return await getTopicsForChampionshipBlockConnection(contentValue);
    }
    else{
      return await getSubtopicsForChampionshipBlockConnection(contentValue);
    }
  }

}