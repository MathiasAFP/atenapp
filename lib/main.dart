import 'package:Atena/connections/credentialConnection.dart';
import 'package:flutter/material.dart';
import 'package:Atena/views/userViews/configView/colorConfigView.dart';
import 'package:Atena/views/pageViews.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
import 'package:Atena/connections/basicData.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: AuthCheckScreen(),
      routes: {
        '/login': (context) => UserSignupView(),
      },
    );
  }
}

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  late Future<String> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    _loadUserFuture = _loadUserType();
  }

  Future<String> _loadUserType() async {
    try {
      final colorConfig = ColorConfig();
      await colorConfig.getColorConfig();

      final userBasicData = await getUserBasicDataConnection();

      if (userBasicData.isNotEmpty &&
          userBasicData.containsKey("userType") &&
          userBasicData["userType"] != null) {
        return userBasicData["userType"].toString();
      }

      debugPrint("Token inválido (sem userType). Limpando token local.");
      await deleteToken(); 
      return "";

    } catch (e) {
      debugPrint("Erro ao carregar usuário (provável token expirado): $e");
      await deleteToken(); 
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadUserFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: Image.asset(
                  'assets/logoWithoutBackground.png',
                  width: 200, 
                  height: 200,
                )),
          );
        }

        if (snapshot.hasError) {
          debugPrint("Erro no FutureBuilder: ${snapshot.error}");
          return UserSignupView(); 
        }

        if (snapshot.hasData) {
          final userType = snapshot.data!;

          switch (userType) {
            case "user":
              return UserPageView();
            case "student":
              return StudentPageView();
            case "teacher":
              return TeacherPageView();
            case "school":
              return SchoolPageView();
            default:
              return UserSignupView();
          }
        }

        return UserSignupView();
      },
    );
  }
}