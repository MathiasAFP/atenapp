import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'login_page.dart';

class ChecklistItem {
  final String id;
  String text;
  bool isCompleted;

  ChecklistItem({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted,
    };
  }

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'],
      text: json['text'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  List<ChecklistItem> _items = [];
  final _textController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getString('checklist_items');
    
    if (itemsJson != null) {
      final List<dynamic> decoded = json.decode(itemsJson);
      setState(() {
        _items = decoded.map((item) => ChecklistItem.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = json.encode(_items.map((item) => item.toJson()).toList());
    await prefs.setString('checklist_items', itemsJson);
  }

  Future<void> _addItem() async {
    if (_textController.text.trim().isEmpty) {
      return;
    }

    final newItem = ChecklistItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: _textController.text.trim(),
    );

    setState(() {
      _items.insert(0, newItem);
    });

    _textController.clear();
    await _saveItems();
  }

  Future<void> _toggleItem(int index) async {
    setState(() {
      _items[index].isCompleted = !_items[index].isCompleted;
    });
    await _saveItems();
  }

  Future<void> _deleteItem(int index) async {
    setState(() {
      _items.removeAt(index);
    });
    await _saveItems();
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist de Viagem'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Sair',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            labelText: 'Adicionar item',
                            hintText: 'Ex: Passaporte, Roupas, Câmera...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onSubmitted: (_) => _addItem(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton(
                        onPressed: _addItem,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                if (_items.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.checklist_rtl,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum item adicionado',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Adicione itens à sua lista de viagem',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: item.isCompleted,
                              onChanged: (_) => _toggleItem(index),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            title: Text(
                              item.text,
                              style: TextStyle(
                                decoration: item.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: item.isCompleted
                                    ? Colors.grey
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              color: Colors.red,
                              onPressed: () => _deleteItem(index),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (_items.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total: ${_items.length} item${_items.length != 1 ? 's' : ''} | Concluídos: ${_items.where((item) => item.isCompleted).length}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

