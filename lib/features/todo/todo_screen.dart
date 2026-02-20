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

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // CREATE Logic
  void _addTodo() async {
    if (_taskController.text.trim().isEmpty) return;

    await appDb.todosDao.insertTodo(
      TodosCompanion(title: drift.Value(_taskController.text.trim())),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        automaticallyImplyLeading: false, // Prevents going back to login
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
              stream: appDb.todosDao.watchAllTodos(), // Listening to the DB!
              builder: (context, snapshot) {
                // Handle loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Handle error state
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final todos = snapshot.data ?? [];

                // Handle empty state
                if (todos.isEmpty) {
                  return const Center(
                    child: Text('No tasks yet. Add one above!'),
                  );
                }

                // Render the list
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
