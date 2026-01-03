import 'package:teste/connections/lessonConnection.dart';

class LessonClass {
  Map<String, dynamic> lessonData = {};

  Future<Map<String, dynamic>> saveSubjectData() async {
    lessonData["subjects"] = await getSubjectsConnection({});
    return lessonData;
  }

  Future<Map<String, dynamic>> saveTopicData(subject) async {
    lessonData["topics"] = await getTopicConnection({"subject":subject});
    return lessonData;
  }

  Future<Map<String, dynamic>> saveSubTopicData(topic) async {
    lessonData["subTopics"] = await getSubTopicConnection({"topic":topic});
    return lessonData;
  }

}