import 'package:flutter/material.dart';
import 'package:teste/classes/profileClass.dart';
import 'package:teste/connections/profileConnection.dart';

ProfileClass profileClassInstance = ProfileClass();
bool hasProfileClassData = false;

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    if (hasProfileClassData) {
      return(Scaffold(body: Center(child: Text(profileClassInstance.userData!["msg"]["name"]))));
    }
    return FutureBuilder(future: profileClassInstance.saveUserData(), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
            child: CircularProgressIndicator(),
          );
          }

          if (snapshot.hasData) {
          hasProfileClassData = true;
          var nomeSeguro = snapshot.data?['msg']?['name'] ?? "Nome Indisponível";
          return Scaffold(
              body: Center(child: Text(nomeSeguro.toString()))
          );
      }

          return(Image.network("https://static.vecteezy.com/system/resources/thumbnails/024/405/934/small/icon-tech-error-404-icon-isolated-png.png"));
      }
    );
  }
}