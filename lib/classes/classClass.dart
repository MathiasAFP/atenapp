// ADICIONEI 'as connection' AQUI PARA DIFERENCIAR
import 'package:Atena/connections/classConnection.dart' as connection;

class ClassClass {
  List<Map<dynamic, dynamic>> yourClasses = [];

  Future<String> createClass(name, teacherCode, studentCode) async {
    // AGORA CHAMAMOS A CONEXÃO, NÃO A SI MESMO
    return await connection.createClass(name, teacherCode, studentCode);
  }

  Future<String> enterClass(name, code) async {
    // CORREÇÃO AQUI TAMBÉM
    return await connection.enterClass(name, code);
  }

  Future<void> takeAndSaveYourClasses() async {
    // Aqui também precisa do alias
    yourClasses = await connection.getSchoolClass();
  }

  Future<List<Map<dynamic, dynamic>>> showYourClasses() async {
    return yourClasses;
  }
}