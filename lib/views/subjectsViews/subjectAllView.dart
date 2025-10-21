import 'package:flutter/material.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;

class SubjectProgressPage extends StatelessWidget {
  const SubjectProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.Colors.background_black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/img/example.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Avançado',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '85/100',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Text(
                        'Fazendo por 60 dias',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Linha do tempo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const [
                  _TimelineItem(
                    title: 'Divisão com Vírgula',
                    subtitle: 'Estimativa: 50 horas',
                    isDone: false,
                  ),
                  _TimelineItem(
                    title: 'Potenciação',
                    subtitle: 'Fazendo por 34 horas',
                    isDone: true,
                    highlighted: true,
                  ),
                  _TimelineItem(
                    title: 'Operações com Vírgula',
                    subtitle: 'Feito em 34 horas',
                    isDone: true,
                  ),
                  _TimelineItem(
                    title: 'Operações Básicas',
                    subtitle: 'Feito em 34 horas',
                    isDone: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDone;
  final bool highlighted;

  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.isDone,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // Linha vertical
        Positioned(
          left: 28,
          top: 0,
          bottom: 0,
          child: Container(width: 2, color: Colors.white24),
        ),

        // Conteúdo principal
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícone circular
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone
                      ? (highlighted ? Colors.white : Colors.blueGrey)
                      : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.star,
                  color: isDone ? Colors.black : Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),

              // Textos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
