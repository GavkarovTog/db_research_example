import 'package:db_research_example/database.dart';
import 'package:db_research_example/home_page.dart';
import 'package:db_research_example/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  AppDatabase database = AppDatabase();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => TodoList(database),
      child: const DBExampleApp())
  );
}

class DBExampleApp extends StatelessWidget {
  const DBExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
