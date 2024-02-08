import 'package:db_research_example/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTodoEntryDialog extends StatelessWidget {
  const CreateTodoEntryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController todoContentController = TextEditingController();
    final model = Provider.of<TodoList>(context, listen: false);

    return Dialog(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          const SizedBox(height: 6),
          TextField(
            maxLines: 10,
            controller: todoContentController,
            decoration: InputDecoration(
              labelText: "Enter todo content here...",
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
                model.addTodoItem(todoContentController.text);
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
