import 'package:Atena/connections/connectionsConfig.dart';

Future<dynamic> createChampionshipConnection(name, code) async {
  return await defaultConnection(
    "/championship/createchampionship",
    "POST",
    body: {
      "name": name,
      "code": code
    },
  );
}

Future<dynamic> searchChampionship(name) async {
  return await defaultConnection(
    "/championship/searchchampionship",
    "POST",
    body: {
      "name": name
    },
  );
}

Future<dynamic> enterChampionship(name, code, hierarchyType) async {
  return await defaultConnection(
    "/championship/enterchampionship",
    "POST",
    body: {
      "name": name,
      "code": code,
      "hierarchyType" : hierarchyType
    },
  );
}

Future<dynamic> creatEvent(championshipid, name, finishdate, type) async {
  return await defaultConnection(
    "/championship/createvent",
    "POST",
    body: {
      "championshipid": championshipid,
      "name": name,
      "finishdate": finishdate,
      "type": type
    },
  );
}

Future<dynamic> excludeChampionship(championshipName) async {
  return await defaultConnection(
    "/championship/excludechampionship",
    "POST",
    body: {
      "championshipName": championshipName
    },
  );
}

Future<dynamic> getChampionshipsConnection() async {
  return await defaultConnection(
    "/championship/getchampionships",
    "GET",
  );
}

Future<dynamic> getSubjectsForChampionshipBlockConnection() async {
  return await defaultConnection(
    "/championship/getsubjects",
    "GET",
    body: {},
  ); 
}

Future<dynamic> getSubtopicsForChampionshipBlockConnection(topic) async {
  return await defaultConnection(
    "/championship/getsubtopics",
    "POST",
    body: {
      "topic":topic
    },
  ); 
}

Future<dynamic> getTopicsForChampionshipBlockConnection(subject) async {
  return await defaultConnection(
    "/championship/gettopics",
    "POST",
    body: {
      "subject":subject
    },
  ); 
}

Future<dynamic> createYourQuestionsChampionshipBlock(championshipName) async {
  return await defaultConnection(
    "/championship/excludechampionship",
    "POST",
    body: {
      "championshipName": championshipName
    },
  );
}

Future<dynamic> createQuestionsChampionshipBlock(championshipName) async {
  return await defaultConnection(
    "/championship/excludechampionship",
    "POST",
    body: {
      "championshipName": championshipName
    },
  );
}

Future<dynamic> createFilteredQuestionsChampionshipBlock(championshipName) async {
  return await defaultConnection(
    "/championship/excludechampionship",
    "POST",
    body: {
      "championshipName": championshipName
    },
  );
}

Future<dynamic> createLessonChampionshipBlock(championshipName) async {
  return await defaultConnection(
    "/championship/excludechampionship",
    "POST",
    body: {
      "championshipName": championshipName
    },
  );
}