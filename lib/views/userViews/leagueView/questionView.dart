import 'package:flutter/material.dart';
import '../../../classes/questionClass.dart';

class QuestionScreen extends StatefulWidget {
  final String subject;
  final String topic;
  final String subTopic;
  final int difficulty;
  final String searchType;
  final int howMany;

  const QuestionScreen({
    super.key,
    required this.subject,
    required this.topic,
    required this.subTopic,
    required this.difficulty,
    required this.searchType,
    required this.howMany,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final QuestionClass questionClass = QuestionClass();
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      await questionClass.takeSaveQuestionDataFunction(
        widget.subject,
        widget.topic,
        widget.subTopic,
        widget.difficulty,
        widget.searchType,
        widget.howMany,
      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      questionClass.deleteFirstQuestion(); // remove atual
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_hasError) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Erro ao carregar questões',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (questionClass.questionsList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Nenhuma questão restante.'),
        ),
      );
    }

    final question = questionClass.questionsList[0];

    return Scaffold(
      appBar: AppBar(title: const Text("Responda")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextQuestion,
              child: const Text("Próxima questão"),
            ),
          ],
        ),
      ),
    );
  }
}
