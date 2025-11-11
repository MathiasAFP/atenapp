import 'package:flutter/material.dart';
import 'package:muto_system/connections/basicData.dart';

class LoadingdadosView extends StatelessWidget {
  const LoadingdadosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          // 👇 aceita Map<dynamic, dynamic> sem erro de tipo
          child: FutureBuilder<Map<dynamic, dynamic>>(
            future: getUserBasicDataConnection(),
            builder: (context, snapshot) {
              // LOADING
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Carregando dados do usuário...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // ERRO
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Erro ao carregar os dados:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      snapshot.error.toString().replaceAll("Exception: ", ""),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                );
              }

              // SUCESSO
              if (snapshot.hasData) {
                final data = Map<String, dynamic>.from(snapshot.data!);

                final name = data['name'] ?? 'Nome Não Encontrado';
                final leagueId = data['leagueId'] ?? 'N/A';
                final leagueType = data['leagueType'] ?? 'N/A';

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "INFORMAÇÕES BÁSICAS DO USUÁRIO",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                      const Divider(height: 20, thickness: 2),
                      _buildInfoRow("Nome Completo:", name, Icons.person),
                      const SizedBox(height: 15),
                      _buildInfoRow(
                        "ID da Liga:",
                        leagueId.toString(),
                        Icons.group,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoRow(
                        "Tipo de Liga:",
                        leagueType.toString().toUpperCase(),
                        Icons.category,
                      ),
                    ],
                  ),
                );
              }

              // SEM DADOS
              return const Text("Nenhum dado disponível.");
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blueGrey, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
