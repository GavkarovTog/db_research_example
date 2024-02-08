import 'package:db_research_example/database.dart';
import 'package:db_research_example/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTodoEntryDialog extends StatelessWidget {
  final TodoItem todoItem;
  const EditTodoEntryDialog({super.key, required this.todoItem});

  @override
  Widget build(BuildContext context) {
    TextEditingController todoItemContent = TextEditingController(text: todoItem.content);

    return Dialog(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          const SizedBox(height: 6),
          TextField(
            controller: todoItemContent,
            decoration: InputDecoration(
                labelText: "Enter todo content here",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35)
                )
            ),
          ),

          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                TodoList model = Provider.of<TodoList>(context, listen: false);
                model.changeTodoItem(todoItem.id, todoItemContent.text);
                Navigator.pop(context);
              }, child: const Text("Save")),
              const SizedBox(width: 7,),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text("Cancel"))
            ],
          )
        ],
      ),
    );
  }
}
