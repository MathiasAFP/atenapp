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
    final theme = Theme.of(context);
    final completedCount = _items.where((item) => item.isCompleted).length;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Minha Viagem',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_items.length} itens • $completedCount concluídos',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: _logout,
                          icon: const Icon(Icons.logout_rounded),
                          color: Colors.white,
                          tooltip: 'Sair',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Campo de adicionar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                hintText: 'Adicionar novo item...',
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              onSubmitted: (_) => _addItem(),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.primary,
                                  theme.colorScheme.secondary,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: _addItem,
                              icon: const Icon(Icons.add_rounded),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Lista de itens
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _items.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.checklist_rtl_rounded,
                                    size: 60,
                                    color: theme.colorScheme.primary.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Nenhum item ainda',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Adicione itens à sua lista de viagem',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              final item = _items[index];
                              return Dismissible(
                                key: Key(item.id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.tertiary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.only(right: 20),
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  _deleteItem(index);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    leading: GestureDetector(
                                      onTap: () => _toggleItem(index),
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: item.isCompleted
                                                ? theme.colorScheme.secondary
                                                : Colors.grey.shade300,
                                            width: 2,
                                          ),
                                          color: item.isCompleted
                                              ? theme.colorScheme.secondary
                                              : Colors.transparent,
                                        ),
                                        child: item.isCompleted
                                            ? const Icon(
                                                Icons.check_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              )
                                            : null,
                                      ),
                                    ),
                                    title: Text(
                                      item.text,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        decoration: item.isCompleted
                                            ? TextDecoration.lineThrough
                                            : null,
                                        color: item.isCompleted
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade800,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.grey.shade400,
                                      ),
                                      onPressed: () => _deleteItem(index),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
