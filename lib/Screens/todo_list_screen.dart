import 'package:flutter/material.dart';
import 'package:todo_list/Models/todo_item.dart';
import 'package:todo_list/widgets/add_todo_dialog.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> _todoItems = [];

  void _addTodoItem(String task) {
    setState(() {
      _todoItems.add(TodoItem(task: task));
    });
  }

  void _removeToDoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _toggledToDoItem(int index) {
    setState(() {
      _todoItems[index].isDone = !_todoItems[index].isDone;
    });
  }

  void _renameToDoTask(int index, String newTask) {
    setState(() {
      _todoItems[index].task = newTask;
    });
  }

  void _onRenameTask(int index) {
    final TextEditingController controller =
        TextEditingController(text: _todoItems[index].task);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit Task'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter your new task',
                labelText: 'Task Title'),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  final newTitle = controller.text;
                  if (newTitle.isNotEmpty) {
                    _renameToDoTask(index, newTitle);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void promptAddTodoItem() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddTodoDialog(addTodoItem: _addTodoItem);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _todoItems.length,
            itemBuilder: (context, index) {
              final item = _todoItems[index];
              return TodoListItem(
                item: item,
                onItemToggled: () => _toggledToDoItem(index),
                onItemDeleted: () => _removeToDoItem(index),
                onRenameTask: () => _onRenameTask(index),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: promptAddTodoItem,
        tooltip: 'Add Task',
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
