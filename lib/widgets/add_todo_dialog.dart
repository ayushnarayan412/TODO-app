import 'package:flutter/material.dart';

class AddTodoDialog extends StatelessWidget {
  final Function(String) addTodoItem;
  final TextEditingController _textFieldController = TextEditingController();

  AddTodoDialog({super.key,required this.addTodoItem});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new task'),
      content: TextFormField(
        controller: _textFieldController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Enter your task here',
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
             Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
               if (_textFieldController.text.isNotEmpty) {
                addTodoItem(_textFieldController.text);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'))
      ],
    );
  }
}
