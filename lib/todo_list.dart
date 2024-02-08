import 'package:db_research_example/database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';

class TodoList extends ChangeNotifier {
  AppDatabase db;
  TodoList(this.db);

  Future<List<TodoItem>> get todoEntries => db.select(db.todoItems).get();
  void addTodoItem(String content) {
    db.into(db.todoItems).insert(
        TodoItemsCompanion.insert(
            content: content,
        )
    );
    notifyListeners();
  }

  void setChecked(int id, bool checked) async {
    await (db.update(db.todoItems)
          ..where((tbl) => tbl.id.equals(id)))
          .write(TodoItemsCompanion(checked: Value(checked)));
  }

  void changeTodoItem(int id, String content) async {
    await (db.update(db.todoItems)
        ..where((tbl) => tbl.id.equals(id))
      ).write(TodoItemsCompanion(content: Value(content)));
    notifyListeners();
  }

  void deleteTodoItem(int id) async {
    await (db.delete(db.todoItems)
        ..where((tbl) => tbl.id.equals(id))).go();
    notifyListeners();
  }
}