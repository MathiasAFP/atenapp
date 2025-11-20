import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChampionshipCardWidget extends StatelessWidget {

  final String name; 

  const ChampionshipCardWidget({
    super.key, 
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: [
      Text(name)
    ]));
  }
  
}