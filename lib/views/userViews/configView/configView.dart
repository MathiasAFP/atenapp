import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = const Color(0xFF0D47A1);
Color secondaryColor = const Color(0xFF1565C0);
Color tertiaryColor = const Color(0xFF1976D2);
Color quaternaryColor = const Color(0xFFBBDEFB);
Color quinternaryColor = const Color(0xFFE3F2FD);

Color darkPrimaryColor = const Color.fromARGB(255, 223, 224, 226);
Color darkSecondaryColor = const Color.fromARGB(255, 22, 48, 93);
Color darkTertiaryColor = const Color.fromARGB(255, 60, 82, 145);
Color darkQuaternaryColor = const Color.fromARGB(255, 9, 12, 44);
Color darkQuinternaryColor = const Color.fromARGB(255, 9, 12, 15);

Color lightPrimaryColor = const Color(0xFF0D47A1);
Color lightSecondaryColor = const Color(0xFF1976D2);
Color lightTertiaryColor = const Color(0xFF42A5F5);
Color lightQuaternaryColor = const Color(0xFFBBDEFB);
Color lightQuinternaryColor = const Color(0xFFE3F2FD);

// 🔥 Fonte global (AFETA O APP TODO)
double globalFontSize = 16; // padrão médio

class ColorConfig {
  // ============================
  // SALVAR/PEGAR TEMA
  // ============================
  Future<void> saveColorConfig(String color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("colorConfig", color);
  }

  Future<void> getColorConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedColorConfig = prefs.getString("colorConfig");

    if (selectedColorConfig == "dark") {
      primaryColor = darkPrimaryColor;
      secondaryColor = darkSecondaryColor;
      tertiaryColor = darkTertiaryColor;
      quaternaryColor = darkQuaternaryColor;
      quinternaryColor = darkQuinternaryColor;
    } else {
      primaryColor = lightPrimaryColor;
      secondaryColor = lightSecondaryColor;
      tertiaryColor = lightTertiaryColor;
      quaternaryColor = lightQuaternaryColor;
      quinternaryColor = lightQuinternaryColor;
    }
  }

  // ============================
  // SALVAR/PEGAR TAMANHO DA FONTE
  // ============================
  Future<void> saveFontSize(String size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("fontSizeConfig", size);
  }

  Future<void> getFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSize = prefs.getString("fontSizeConfig");

    if (savedSize == "small") {
      globalFontSize = 14;
    } else if (savedSize == "large") {
      globalFontSize = 20;
    } else {
      globalFontSize = 16; // médio padrão
    }
  }
}

class ConfigView extends StatefulWidget {
  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  final colorConfigInstance = ColorConfig();

  Future<void> _changeTheme(String theme) async {
    await colorConfigInstance.saveColorConfig(theme);
    await colorConfigInstance.getColorConfig();
    setState(() {});
  }

  Future<void> _changeFontSize(String size) async {
    await colorConfigInstance.saveFontSize(size);
    await colorConfigInstance.getFontSize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quaternaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ============================
            // BOTÕES DE TEMA
            // ============================
            ElevatedButton(
              onPressed: () => _changeTheme("light"),
              child: Text("Modo claro", style: TextStyle(fontSize: globalFontSize)),
            ),
            ElevatedButton(
              onPressed: () => _changeTheme("dark"),
              child: Text("Modo escuro", style: TextStyle(fontSize: globalFontSize)),
            ),

            const SizedBox(height: 40),

            // ============================
            // BOTÕES DE FONTE - NOVO
            // ============================
            ElevatedButton(
              onPressed: () => _changeFontSize("small"),
              child: Text("Fonte pequena", style: TextStyle(fontSize: globalFontSize)),
            ),
            ElevatedButton(
              onPressed: () => _changeFontSize("medium"),
              child: Text("Fonte média", style: TextStyle(fontSize: globalFontSize)),
            ),
            ElevatedButton(
              onPressed: () => _changeFontSize("large"),
              child: Text("Fonte grande", style: TextStyle(fontSize: globalFontSize)),
            ),
          ],
        ),
      ),
    );
  }
}
