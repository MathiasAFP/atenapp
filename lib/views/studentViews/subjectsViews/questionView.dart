import 'package:flutter/material.dart';
import 'package:muto_system/models/QuestionModel.dart';

class QuestaoCard extends StatefulWidget {
  final String tituloMateria;
  final String textoQuestao;
  final List<String> opcoes;
  final Function(String opcaoSelecionada)? onConfirmar;
  final String imagemFundoAsset;

  const QuestaoCard({
    super.key,
    required this.tituloMateria,
    required this.textoQuestao,
    required this.opcoes,
    this.onConfirmar,
    this.imagemFundoAsset = 'assets/image_d8ed45_background.png',
  });

  factory QuestaoCard.fromModel({
    required QuestionModel question,
    required String tituloMateria,
    required String textoQuestao,
    required List<String> opcoes,
    Function(String opcaoSelecionada)? onConfirmar,
    String imagemFundoAsset = 'assets/image_d8ed45_background.png',
  }) {
    return QuestaoCard(
      tituloMateria: tituloMateria,
      textoQuestao: textoQuestao,
      opcoes: opcoes,
      onConfirmar: onConfirmar,
      imagemFundoAsset: imagemFundoAsset,
    );
  }

  @override
  State<QuestaoCard> createState() => _QuestaoCardState();
}

class _QuestaoCardState extends State<QuestaoCard> {
  String? _opcaoSelecionada;

  // Remova as constantes de cores fixas aqui

  @override
  Widget build(BuildContext context) {
    // Definição das cores baseadas no tema
    final colorScheme = Theme.of(context).colorScheme;
    final corFundoPrincipal = colorScheme.background;
    final corCardPrincipal = colorScheme.surface;
    final corTextoClaro = colorScheme.onSurface; // Texto primário
    final corTextoSecundario = colorScheme.onSurface.withOpacity(
      0.7,
    ); // Texto secundário
    final corDestaque = colorScheme.primary; // Cor de destaque/Primary
    final corTituloQuestao = colorScheme.onSurface.withOpacity(0.5);

    final headerWidget = Container(
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Use cores do tema ou um gradiente que adapte
          colors: [corFundoPrincipal.withOpacity(0.9), corFundoPrincipal],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: corTextoClaro),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.tituloMateria.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: corTextoSecundario,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Questão de Múltipla Escolha',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: corTextoClaro,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    final cardBody = Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: corCardPrincipal,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enem PPL | M0516',
            style: TextStyle(
              color: corTituloQuestao,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            widget.textoQuestao,
            textAlign: TextAlign.justify,
            style: TextStyle(color: corTextoClaro, fontSize: 18, height: 1.4),
          ),
          const SizedBox(height: 24),

          ...widget.opcoes.map(
            (opcao) => _buildOptionTile(
              opcao,
              corDestaque,
              corCardPrincipal,
              corTextoClaro,
              corTextoSecundario,
            ),
          ),
          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [corDestaque, corDestaque.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: corDestaque.withOpacity(
                      _opcaoSelecionada != null ? 0.5 : 0.1,
                    ),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed:
                    _opcaoSelecionada != null && widget.onConfirmar != null
                    ? () => widget.onConfirmar!(_opcaoSelecionada!)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Confirmar Resposta',
                  style: TextStyle(
                    color: corTextoClaro,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: corFundoPrincipal,
      body: SingleChildScrollView(
        child: Column(
          children: [
            headerWidget,
            Transform.translate(offset: const Offset(0, -20), child: cardBody),
          ],
        ),
      ),
    );
  }

  // Modifique o método para aceitar as cores como parâmetro (ou use Theme.of(context) diretamente)
  Widget _buildOptionTile(
    String opcao,
    Color corDestaque,
    Color corCardPrincipal,
    Color corTextoClaro,
    Color corTextoSecundario,
  ) {
    final isSelected = _opcaoSelecionada == opcao;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _opcaoSelecionada = opcao;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? corDestaque.withOpacity(0.2) : corCardPrincipal,
            border: Border.all(
              color: isSelected
                  ? corDestaque
                  : corTextoSecundario.withOpacity(0.3),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: corDestaque.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? corDestaque : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? corDestaque
                        : corTextoSecundario.withOpacity(0.6),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isSelected
                    ? Icon(Icons.check, color: corTextoClaro, size: 16)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  opcao,
                  style: TextStyle(
                    color: isSelected ? corTextoClaro : corTextoSecundario,
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
