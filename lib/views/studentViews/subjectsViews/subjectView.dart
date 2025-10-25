import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart'; // Import necessário
import 'package:muto_system/models/QuestionModel.dart';
import 'package:muto_system/views/studentViews/subjectsViews/questionView.dart';
import 'package:muto_system/views/widgets/SubjectLine.dart';

class SubjectProgressPage extends StatelessWidget {
  const SubjectProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cores obtidas do tema
    final colorScheme = Theme.of(context).colorScheme;
    final corFundo = colorScheme.background;
    final corTextoPrincipal = colorScheme.onBackground;

    final questionExample = QuestionModel(
      id: 1,
      subject: "Matemática Avançada",
      text: "Qual é o valor de x na equação 2x + 5 = 15?",
      options: ["A) 3", "B) 4", "C) 5", "D) 6"],
      correctAnswer: "C) 5",
    );

    return Scaffold(
      backgroundColor: corFundo, // Fundo se adapta ao tema
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context), // Passando o context para o header
            const SizedBox(height: 24),

            _buildStatisticsCards(context),
            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Fase Atual',
                style: TextStyle(
                  color: corTextoPrincipal, // Cor do texto se adapta ao fundo
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            SubjectLine(
              colors: const [Colors.blue],
              circleSize: 80,
              spacing: 60,

              onItemTap: (index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestaoCard.fromModel(
                      question: questionExample,
                      tituloMateria: questionExample.subject,
                      textoQuestao: questionExample.text,
                      opcoes: questionExample.options,
                      onConfirmar: (opcaoSelecionada) {
                        print("Opção selecionada: $opcaoSelecionada");
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Recebe o BuildContext para acessar o AdaptiveTheme
  Widget _buildHeader(BuildContext context) {
    // Obtém o modo de tema atual para exibir o ícone correto
    final currentMode = AdaptiveTheme.of(context).mode;
    IconData icon;

    if (currentMode == AdaptiveThemeMode.system) {
      icon = Icons.brightness_auto;
    } else if (currentMode == AdaptiveThemeMode.dark) {
      icon = Icons.dark_mode;
    } else {
      icon = Icons.light_mode;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade800, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Botão para alternar o tema
                IconButton(
                  icon: Icon(icon, color: Colors.white),
                  onPressed: () {
                    // Alterna entre Light, Dark e System, e salva a preferência.
                    AdaptiveTheme.of(context).toggleThemeMode();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white10,
                  // Necessário que a imagem exista no caminho 'assets/img/example.png'
                  // Caso contrário, use `const Icon(Icons.person, color: Colors.white, size: 40)`
                  // para evitar erro de asset.
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
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '85/100 pontos',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      '60 dias de estudo contínuo',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCards(BuildContext context) {
    // A cor de superfície (card) se adapta
    final corCardSurface = Theme.of(context).colorScheme.surface;
    final corTextoPrincipal = Theme.of(context).colorScheme.onSurface;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildStatCard(
            context,
            icon: Icons.star_rate_rounded,
            title: '85/100',
            subtitle: 'Pontuação Total',
            color: Colors.amber.shade700,
            cardColor: corCardSurface,
            textColor: corTextoPrincipal,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            context,
            icon: Icons.local_fire_department_rounded,
            title: '60 dias',
            subtitle: 'Streak de Estudo',
            color: Colors.red.shade700,
            cardColor: corCardSurface,
            textColor: corTextoPrincipal,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color cardColor,
    required Color textColor,
  }) {
    // Usamos a cor primária do tema para o border no modo CLARO,
    // e o cinza escuro para o modo ESCURO, mantendo o contraste.
    final useDarkBackground = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme; // Obtido localmente

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // O background do card é a cor de surface do tema
          color: useDarkBackground ? cardColor.withOpacity(0.8) : cardColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: useDarkBackground
                ? color.withOpacity(0.5)
                : colorScheme.primary.withOpacity(0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor, // Cor do texto se adapta ao tema
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
