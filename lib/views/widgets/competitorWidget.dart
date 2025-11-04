import 'package:flutter/material.dart';


class Competitor extends StatelessWidget {
  final String name;
  final int points;

  const Competitor({
    Key? key,
    required this.name,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),

      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      
      trailing: Text(
        points.toString(),
        style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
      ),
      
      onTap: () {
        print("Botão clicado: Navegando para detalhes de $name");
        
        Navigator.push(
          context,
          MaterialPageRoute(
             builder: (context) => Scaffold(appBar: AppBar(title: Text("Detalhes de $name"))),
          ),
        );
      },
    );
  }
}