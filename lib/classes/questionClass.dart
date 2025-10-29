import 'package:muto_system/connections/questionConnection.dart';
import 'package:flutter/material.dart';

class QuestionClass {
  final List<dynamic> questionsList = [];

  Future<void> takeSaveQuestionDataFunction(subject, topic, subTopic, difficulty, searchType, howMany) async {
    final List<dynamic> questions = await getQuestionConnection(subject, topic, subTopic, difficulty, searchType, howMany);
    questionsList.add(questions);
  }

  Future<void> deleteFirstQuestion() async{
    questionsList.removeAt(0);
  }

  Future<void> showDataQuestion() async {
    return questionsList[0];
  } 

}



/*
para depois pegar os valores no front:
final Map<String, dynamic> resposta = await showQuestionScreenFunction(
    subject, topic, subTopic, difficulty, searchType, howMany);

print(resposta['subject']);

*/