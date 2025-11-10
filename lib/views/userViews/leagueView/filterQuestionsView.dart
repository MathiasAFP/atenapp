import 'package:flutter/material.dart';
// Importe suas classes e a tela de destino
import 'package:muto_system/classes/questionClass.dart';
import 'package:muto_system/views/userViews/leagueView/questionView.dart'; // Verifique se este é o caminho correto para QuestionScreen

final QuestionClassInstance = QuestionClass();
bool _firstExecution = false;

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _loading = true; // controla o carregamento

  // Armazena o JSON completo (para não precisar pegar do snapshot toda hora)
  Map<String, dynamic> _allQuestionInfo = {};

  // Listas para popular os menus
  List<String> _topics = [];
  List<dynamic> _subtopics = [];

  // Armazena as seleções do usuário
  String? _selectedSubject;
  String? _selectedTopic;
  String? _selectedSubtopic;
  String? _selectedDifficultyString; // Armazena "Fácil", "Médio", etc.
  int? _selectedHowMany;

  // Mapa para converter String de dificuldade para int
  final Map<String, int> difficultyMap = {
    'Fácil': 1,
    'Médio': 2,
    'Difícil': 3,
  };

  @override
  void initState() {
    super.initState();
    _loadCompetitors();
  }

  Future<void> _loadCompetitors() async {
    if (_firstExecution == false) {
      // Carrega os dados na CLASSE
      await QuestionClassInstance.getQuestionInfo();
      _firstExecution = true;
    }

    setState(() {
      _loading = false;
    });
  }

  // --- Funções de atualização em cascata ---
  void _onSubjectSelected(String subject) {
    setState(() {
      _selectedSubject = subject;
      // Reseta os níveis seguintes
      _selectedTopic = null;
      _selectedSubtopic = null;
      // Popula a PRÓXIMA lista (Tópicos)
      _topics = (_allQuestionInfo[subject] as Map<String, dynamic>).keys.toList();
      _subtopics = []; // Limpa a lista de subtópicos
    });
  }

  void _onTopicSelected(String topic) {
    setState(() {
      _selectedTopic = topic;
      // Reseta o nível seguinte
      _selectedSubtopic = null;
      // Popula a PRÓXIMA lista (Subtópicos)
      _subtopics = _allQuestionInfo[_selectedSubject]![topic] as List<dynamic>;
    });
  }

  // --- Funções de verificação e navegação ---
  bool _areAllOptionsSelected() {
    return 
        _selectedSubtopic != null &&
        _selectedDifficultyString != null &&
        _selectedHowMany != null;
  }

  void _navigateToQuestionScreen() {
    if (!_areAllOptionsSelected()) return; // Segurança

    // Converte a dificuldade de String para int
    final int difficultyInt = difficultyMap[_selectedDifficultyString!] ?? 1;

    Navigator.push(
      context,
      MaterialPageRoute(
        // Navega para a tela que você forneceu
        builder: (context) => QuestionScreen(
          subTopic: _selectedSubtopic!,
          difficulty: difficultyInt,
          howMany: 1
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Liga - Configurar Jogo')),
      body: FutureBuilder<Map<String, dynamic>>( // Tipo corrigido
        future: QuestionClassInstance.showQuestionInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar participantes"));
          }

          if (snapshot.hasData) {
            // Salva o mapa de dados no estado (só na primeira vez)
            if (_allQuestionInfo.isEmpty) {
              _allQuestionInfo = snapshot.data as Map<String, dynamic>;
            }
            
            final subjects = _allQuestionInfo.keys.toList();

            if (subjects.isEmpty) {
              return const Center(child: Text("Nenhuma matéria encontrada"));
            }

            // Usamos SingleChildScrollView para evitar overflow
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  // --- 1. SELEÇÃO DE MATÉRIA ---
                  ExpansionTile(
                    title: Text(_selectedSubject ?? '1. Escolha a Matéria'),
                    children: subjects.map((subject) {
                      return ListTile(
                        title: Text(subject),
                        onTap: () => _onSubjectSelected(subject),
                      );
                    }).toList(),
                  ),
                  
                  SizedBox(height: 16),

                  // --- 2. SELEÇÃO DE TÓPICO (só aparece se matéria foi selecionada) ---
                  if (_selectedSubject != null)
                    ExpansionTile(
                      title: Text(_selectedTopic ?? '2. Escolha o Tópico'),
                      children: _topics.map((topic) {
                        return ListTile(
                          title: Text(topic),
                          onTap: () => _onTopicSelected(topic),
                        );
                      }).toList(),
                    ),
                  
                  SizedBox(height: 16),

                  // --- 3. SELEÇÃO DE SUBTÓPICO (só aparece se tópico foi selecionado) ---
                  if (_selectedTopic != null)
                    ExpansionTile(
                      title: Text(_selectedSubtopic ?? '3. Escolha o Subtópico'),
                      children: _subtopics.map((subtopic) {
                        final subtopicStr = subtopic.toString();
                        return ListTile(
                          title: Text(subtopicStr),
                          onTap: () {
                            setState(() => _selectedSubtopic = subtopicStr);
                          },
                        );
                      }).toList(),
                    ),
                  
                  SizedBox(height: 24),

                  // --- 4. SELEÇÃO DE DIFICULDADE ---
                  DropdownButtonFormField<String>(
                    value: _selectedDifficultyString,
                    hint: Text('4. Escolha a Dificuldade'),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    items: ['Fácil', 'Médio', 'Difícil'].map((d) {
                      return DropdownMenuItem(value: d, child: Text(d));
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedDifficultyString = value);
                    },
                  ),
                  
                  SizedBox(height: 16),

                  // --- 5. SELEÇÃO DE QUANTIDADE ---
                  DropdownButtonFormField<int>(
                    value: _selectedHowMany,
                    hint: Text('5. Escolha a Quantidade'),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    items: [5, 10, 15, 20].map((q) {
                      return DropdownMenuItem(value: q, child: Text('$q questões'));
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedHowMany = value);
                    },
                  ),
                  
                  SizedBox(height: 32),

                  // --- 6. BOTÃO DE INICIAR ---
                  ElevatedButton(
                    onPressed: _areAllOptionsSelected() ? _navigateToQuestionScreen : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(fontSize: 18),
                      disabledBackgroundColor: Colors.grey[300]
                    ),
                    child: Text('Iniciar Questionário'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Erro inesperado"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FilterScreen()));
      }),
    );
  }
}