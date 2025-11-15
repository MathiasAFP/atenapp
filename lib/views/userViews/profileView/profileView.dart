import 'package:Atena/views/userViews/configView/configView.dart';
import 'package:flutter/material.dart';

class UserProfileView extends StatefulWidget {
  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  Widget _buildStatColumn(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: globalFontSize, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: primaryColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quinternaryColor,
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 380,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
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

                  Positioned(
                    top: 40,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ConfigView()),
                            ).then((value) {
                              setState(() {}); // ← atualiza tema ao voltar
                            });
                          },
                          child: const Icon(Icons.color_lens),
                        ),
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/129172387?v=4"),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Maurício Reis Doefer',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Estudante do IFC',
                          style: TextStyle(fontSize: 16, color: primaryColor),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

                  Positioned(
                    bottom: 0,
                    left: 16,
                    right: 16,
                    child: Card(
                      color: secondaryColor,
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
