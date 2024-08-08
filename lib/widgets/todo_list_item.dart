import 'package:flutter/material.dart';
import 'package:todo_list/Models/todo_item.dart';

//edit task option
//priortize the task
//hibe ldb -> local data base

class TodoListItem extends StatelessWidget {
  final TodoItem item;
  final VoidCallback onItemToggled;
  final VoidCallback onItemDeleted;
  final VoidCallback onRenameTask;
  const TodoListItem(
      {super.key,
      required this.item,
      required this.onItemToggled,
      required this.onItemDeleted,
      required this.onRenameTask});
 

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
          leading: Checkbox(
              value: item.isDone,
              onChanged: (bool? value) {
                onItemToggled();
              }),
          title: Text(
            item.task,
            style: TextStyle(
              decoration: item.isDone ? TextDecoration.lineThrough : null,
              fontSize: 18,
            ),
          ),
          trailing: Wrap(
            spacing: -16,
            children: [
              IconButton(
                  onPressed: onRenameTask,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: onItemDeleted,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          )),
    );
  }
}
