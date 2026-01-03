import 'connectionFunctions.dart';

getSubjectsConnection(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("get", "lesson/getsubjects", body);
}

getTopicConnection(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("post", "lesson/gettopic", body);
}

getSubTopicConnection(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("post", "lesson/getsubtopic", body);
}