import 'package:teste/connections/profileConnection.dart';

class ProfileClass {
  Map<String, dynamic> userData = {};

  Future<Map<String, dynamic>> saveUserData() async {
    userData = await getBasicDataConnection({});
    return userData;
  }

}