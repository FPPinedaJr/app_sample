import 'package:app_example/core/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:app_example/core/database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _taskController = TextEditingController();

  // State variables to hold our session data
  int? _currentUserId;
  bool _isLoadingSession = true;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  // Fetch the user ID from SharedPreferences before building the main UI
  Future<void> _loadSession() async {
    final userId = await sessionManager.getUserId();
    if (mounted) {
      setState(() {
        _currentUserId = userId;
        _isLoadingSession = false;
      });
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // CREATE Logic
  void _addTodo() async {
    // Guard clause: Prevent insertion if input is empty OR if session failed to load
    if (_taskController.text.trim().isEmpty || _currentUserId == null) return;

    await appDb.todosDao.insertTodo(
      TodosCompanion(
        title: drift.Value(_taskController.text.trim()),
        userId: drift.Value(_currentUserId!), // Stamp the foreign key here
      ),
    );
    _taskController.clear();
  }

  // UPDATE Logic
  void _toggleTodo(Todo todo) {
    appDb.todosDao.updateTodo(todo.copyWith(isCompleted: !todo.isCompleted));
  }

  // DELETE Logic
  void _deleteTodo(Todo todo) {
    appDb.todosDao.deleteTodo(todo);
  }

  // LOGOUT Logic
  void _logout() async {
    await sessionManager.clearSession(); // Wipe SharedPreferences
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login'); // Route back to login
    }
  }

  @override
  Widget build(BuildContext context) {
    // Prevent UI rendering until we have the user ID from local storage
    if (_isLoadingSession) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Failsafe in case they somehow bypassed the splash screen without a valid session
    if (_currentUserId == null) {
      return const Scaffold(
        body: Center(child: Text('Session Error: Please log in again.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Input Field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'What needs to be done?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.add, size: 30),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),

          // 2. The Reactive List
          Expanded(
            child: StreamBuilder<List<Todo>>(
              // Pass the securely loaded userId to the DAO query
              stream: appDb.todosDao.watchTodosForUser(_currentUserId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final todos = snapshot.data ?? [];

                if (todos.isEmpty) {
                  return const Center(
                    child: Text('No tasks yet. Add one above!'),
                  );
                }

                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    return ListTile(
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (_) => _toggleTodo(todo),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _deleteTodo(todo),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
