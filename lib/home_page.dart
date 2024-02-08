import 'package:db_research_example/create_todo_entry_dialog.dart';
import 'package:db_research_example/database.dart';
import 'package:db_research_example/edit_todo_entry_dialog.dart';
import 'package:db_research_example/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoEntry extends StatefulWidget {
  final TodoItem todoItem;

  const TodoEntry({super.key, required this.todoItem});

  @override
  State<TodoEntry> createState() => _TodoEntryState();
}

class _TodoEntryState extends State<TodoEntry> {
  late bool checked;

  @override
  void initState() {
    checked = widget.todoItem.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (ctx) => EditTodoEntryDialog(todoItem: widget.todoItem));
            },
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(width: 5,),
          IconButton(
            onPressed: () {
              TodoList model = Provider.of<TodoList>(context, listen: false);
              model.deleteTodoItem(widget.todoItem.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      title: Text(widget.todoItem.content),
      trailing: Checkbox(
        value: checked,
        onChanged: (bool? value) async {
          TodoList model = Provider.of<TodoList>(context, listen: false);
          model.setChecked(widget.todoItem.id, !checked);

          setState(() {
            checked = !checked;
          });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoList>(
      builder: (_, model, __) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const CreateTodoEntryDialog());
            },
            child: const Icon(Icons.add),
          ),
          body: FutureBuilder(
              future: model.todoEntries,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Waiting...");
                } else if (snapshot.hasError) {
                  return Text("There was an error on todo loading: ${snapshot.error.toString()}");
                }

                final todoEntries = snapshot.data!;

                return SafeArea(
                  child: ListView.builder(
                      itemCount: todoEntries.length,
                      itemBuilder: (ctx, index) {
                        return TodoEntry(todoItem: todoEntries[index]);
                      }),
                );
              })),
    );
  }
}
