import 'package:Atena/connections/classConnection.dart' as connection;

class ClassClass {
  List<Map<dynamic, dynamic>> yourClasses = [];

  Future<String> createClass(name, teacherCode, studentCode) async {
    return await connection.createClass(name, teacherCode, studentCode);
  }

  Future<String> enterClass(name, code) async {
    final response = await connection.enterClass(name, code);
    return response[0];
  }

  Future<void> takeAndSaveYourClasses() async {
    yourClasses = await connection.getSchoolClass();
  }

  Future<List<Map<dynamic, dynamic>>> showYourClasses() async {
    return yourClasses;
  }
}