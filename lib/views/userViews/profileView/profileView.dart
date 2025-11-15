import 'package:Atena/views/userViews/configView/colorConfigView.dart';
import 'package:flutter/material.dart';

class UserProfileView extends StatefulWidget {
  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  // Método auxiliar para construir as colunas de estatísticas
  Widget _buildStatColumn(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity, // Ocupa toda a largura
              // Altura definida para englobar a imagem de fundo e o card de stats
              height: 380,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // 1. IMAGEM DE FUNDO
                  Container(
                    height: 250, // Altura da imagem de fundo visível
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        // Substitua pelo seu asset de fundo
                        image: NetworkImage(
                            'https://tecnico-informatica.concordia.ifc.edu.br/wp-content/uploads/sites/20/2017/12/IMG-20171128-WA0003.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black54,
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),

                  // 2. CONTEÚDO CENTRALIZADO (Foto, Nome, Fogueira, etc.)
                  Positioned(
                    top: 40, // Espaço do topo (ajustado para a barra de status)
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          // Usando sua imagem de assets como placeholder para o perfil
                          backgroundImage:
                              NetworkImage("https://avatars.githubusercontent.com/u/129172387?v=4"),
                        ),
                        const SizedBox(height: 12),
                        const Text('Maurício Reis Doefer',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 4),
                        const Text('Estudante do IFC',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70)),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department,
                                  color: Colors.orange, size: 18),
                              SizedBox(width: 6),
                              Text('224 dias',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3. CARD DE ESTATÍSTICAS (Posicionado na parte inferior)
                  Positioned(
                    bottom: 0,
                    left: 16,
                    right: 16,
                    child: Card(
                      color: Colors.black.withOpacity(0.5), // Cor escura semi-transparente
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatColumn('Avançado', 'Mat. 32/78'),
                            _buildStatColumn('Nível', '54'),
                            _buildStatColumn('Liga', 'Platina (2º)'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}