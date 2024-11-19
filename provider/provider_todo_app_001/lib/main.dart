import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app_001/pages/todos_page.dart';
import 'package:provider_todo_app_001/providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<TodoFilter, TodoFilterState>(
            create: (context) => TodoFilter()),
        StateNotifierProvider<TodoSearch, TodoSearchState>(
            create: (context) => TodoSearch()),
        StateNotifierProvider<TodoList, TodoListState>(
            create: (context) => TodoList()),
        StateNotifierProvider<ActiveTodoCount, ActiveTodoCountState>(
            create: (context) => ActiveTodoCount()),
        StateNotifierProvider<FilteredTodos, FilteredTodosState>(
            create: (context) => FilteredTodos()),
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TodosPage(),
      ),
    );
  }
}
