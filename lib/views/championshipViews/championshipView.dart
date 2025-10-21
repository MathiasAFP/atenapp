import 'package:flutter/material.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/widgets/CampCard.dart';

class ChampionshipView extends StatefulWidget {
  @override
  State<ChampionshipView> createState() => _ChampionshipViewState();
}

class _ChampionshipViewState extends State<ChampionshipView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        title: Text(
          'Championship View',
          style: TextStyle(color: ThemeColors.Colors.background_white),
        ),
        backgroundColor: ThemeColors.Colors.background_black,
        centerTitle: true,
      ),
      backgroundColor: ThemeColors.Colors.background_black,
      body: ListView(
        children: [
          Column(
            children: [
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
