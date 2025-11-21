import 'package:Atena/connections/classConnection.dart';

class ClassClass {
  List<Map<dynamic, dynamic>> yourClasses = [];

  Future<String> createClass(name, teacherCode, studentCode) async {
    return await createClass(name, teacherCode, studentCode);
  }

  Future<String> enterClass(name, code) async {
    return await enterClass(name, code);
  }

  Future<void> takeAndSaveYourClasses() async {
    yourClasses = await getSchoolClass();
  }

  Future<List<Map<dynamic, dynamic>>> showYourClasses() async {
    return yourClasses;
  }

}