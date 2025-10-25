import 'package:flutter/material.dart';
import 'package:muto_system/models/ProfileModel.dart';
// NOTE: Você precisará garantir que 'package:muto_system/models/ProfileModel.dart'
// e os assets de imagem estejam corretamente configurados.

// =========================================================================
// MOCK DE DADOS (Mantido)
// =========================================================================
const Map<String, dynamic> _MOCK_PROFILE_DATA = {
  'uid': 'user_static_001',
  'full_name': 'Maurício Reis Doefer',
  'role_status': 'Estudante do IFC (Dados Síncronos)',
  'email': 'mauricio@ifc.edu.br',
  'profile_picture_url': 'assets/img/example.png',
  'cover_image_url': 'assets/img/ColorExample.png',
  'current_level': 54,
  'study_streak_days': 224,
  'league_ranking': 'Platina (2º)',
  'current_subject_progress': 'Mat. 32/78',
  'featured_achievements': ['Fogo Diário', 'Estrela Dourada', 'Vencedor'],
};

// =========================================================================
// WIDGET AUXILIAR (_StatusInfo)
// Recebe a cor do texto principal via construtor, tornando-o adaptável.
// =========================================================================
class _StatusInfo extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;

  const _StatusInfo({
    required this.title,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: textColor, // Cor dinâmica
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: textColor.withOpacity(0.7),
          ), // Cor secundária baseada na principal
        ),
      ],
    );
  }
}

// =========================================================================
// PÁGINA DE PERFIL (ProfilePage)
// Utiliza Theme.of(context) para cores dinâmicas.
// =========================================================================
class ProfilePage extends StatelessWidget {
  final UserProfileModel profile;

  // Carrega os dados do mapa estático no construtor
  ProfilePage({super.key})
    // NOTE: UserProfileModel.fromMap deve estar definido na classe ProfileModel
    // conforme o último código que você forneceu.
    : profile = UserProfileModel.fromMap(_MOCK_PROFILE_DATA);

  // Função auxiliar para mapear nomes de conquistas para Ícones
  IconData _getAchievementIcon(String achievementName) {
    switch (achievementName) {
      case 'Vencedor':
        return Icons.military_tech;
      case 'Estrela Dourada':
        return Icons.emoji_events;
      case 'Fogo Diário':
        return Icons.local_fire_department;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Definições de cores baseadas no Tema
    final theme = Theme.of(context);
    final primaryTextColor =
        theme.colorScheme.onSurface; // Ex: Branco no Dark, Preto no Light
    final cardColor = theme.cardColor; // Cor do card definida no Theme Data

    // A cor de fundo principal agora vem do tema
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho com Capa e Foto
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        profile.coverImageUrl ?? 'assets/img/ColorExample.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage(
                      profile.profilePictureUrl ?? 'assets/img/example.png',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            // Nome e Status
            Text(
              profile.fullName,
              style: TextStyle(
                color: primaryTextColor, // Cor do tema
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              profile.roleStatus,
              style: TextStyle(
                color: primaryTextColor.withOpacity(0.7),
                fontSize: 16,
              ), // Cor secundária
            ),

            const SizedBox(height: 8),
            // Sequência de Estudos (Streak)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_fire_department, color: primaryTextColor),
                const SizedBox(width: 6),
                Text(
                  '${profile.studyStreakDays} dias',
                  style: TextStyle(color: primaryTextColor, fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Card de Status e Conquistas
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor, // Cor do tema
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Linha de Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Usa o _StatusInfo refatorado com cor dinâmica
                      _StatusInfo(
                        title: 'Avanço',
                        value: profile.currentSubjectProgress,
                        textColor: primaryTextColor,
                      ),
                      _StatusInfo(
                        title: 'Nível',
                        value: profile.currentLevel.toString(),
                        textColor: primaryTextColor,
                      ),
                      _StatusInfo(
                        title: 'Liga',
                        value: profile.leagueRanking,
                        textColor: primaryTextColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Conquistas em Destaque',
                    style: TextStyle(
                      color: primaryTextColor, // Cor do tema
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Conquistas Mapeadas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: profile.featuredAchievements.map((name) {
                      return Icon(
                        _getAchievementIcon(name),
                        color: theme
                            .colorScheme
                            .secondary, // Usa a cor secundária do tema (ideal para destaque)
                        size: 40,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Card de Ações (Botão e Filtro)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor, // Cor do tema
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Botão Conquistas
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        /* ... */
                      },
                      // O estilo do ElevatedButton geralmente usa as cores do tema por padrão,
                      // mas aqui mantemos uma cor específica (azul) para o Call to Action.
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Todas as Conquistas'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filtro por Matéria
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Filtrar por Matéria: ',
                        style: TextStyle(
                          color: primaryTextColor,
                        ), // Cor do tema
                      ),
                      // DropdownButton fixo
                      DropdownButton<String>(
                        // Cores do DropdownButton ajustadas para o tema
                        dropdownColor: theme.brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        value: 'Matemática',
                        style: TextStyle(color: primaryTextColor),
                        items: const [
                          DropdownMenuItem(
                            value: 'Matemática',
                            child: Text('Matemática'),
                          ),
                          DropdownMenuItem(
                            value: 'História',
                            child: Text('História'),
                          ),
                          DropdownMenuItem(
                            value: 'Química',
                            child: Text('Química'),
                          ),
                        ],
                        onChanged: (value) {
                          /* ... */
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: primaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
