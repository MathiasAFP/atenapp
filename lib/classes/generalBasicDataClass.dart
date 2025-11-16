import 'package:Atena/connections/basicDataConnection.dart';
import 'package:Atena/connections/leagueConnection.dart';

class GeneralBasicData {
  Map<String, dynamic> generalBasicDataMap = {};
  
  Future<void> takeAndSaveGeneralBasicData() async {
    generalBasicDataMap = await generalBasicDataConnection();
  }

  Future<Map<String, dynamic>> showGeneralBasicData() async {
    return generalBasicDataMap;
  }
}