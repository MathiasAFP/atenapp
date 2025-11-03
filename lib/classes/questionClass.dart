import 'package:muto_system/connections/questionConnection.dart';

class QuestionClass {
  List<dynamic> questionsList = [];
  List<String> accuracy = [];

  Future<void> takeSaveQuestionDataFunction(
      subject, topic, subTopic, difficulty, searchType, howMany) async {
    
    final dynamic questionsData = await getQuestionConnection(
        subject, topic, subTopic, difficulty, searchType, howMany);

    if (questionsData is Map<String, dynamic> && 
        questionsData.containsKey("message") &&
        questionsData["message"] is List) 
    {
      questionsList = questionsData["message"] as List<dynamic>;

    } else if (questionsData is List<dynamic>) {
      questionsList = questionsData;
    } else {
      questionsList = [];
    }
  }

  dynamic showFirstQuestion() {
    if (questionsList.isEmpty) {
      return null;
    }
    return questionsList[0];
  }

  void excludeFirstQuestion() {
    if (questionsList.isNotEmpty) {
      questionsList.removeAt(0);
    }
  }

  void verifyAccuracy(String answer){
    if (answer == questionsList[0]["correctOption"]) {
      accuracy += questionsList[0]["difficulty"];
    }
  }

  Future<void> addPointsContext(context) async {
    await addPointsContextConnection(context, accuracy);
  }
}