// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:provider_todo_app_001/models/todo_model.dart';
import 'package:provider_todo_app_001/providers/todo_filter.dart';
import 'package:provider_todo_app_001/providers/todo_list.dart';
import 'package:provider_todo_app_001/providers/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;

  const FilteredTodosState({required this.filteredTodos});

  factory FilteredTodosState.initial() {
    return const FilteredTodosState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos {
  final TodoFilter todoFilter;
  final TodoSearch todoSearch;
  final TodoList todoList;

  FilteredTodos(
      {required this.todoFilter,
      required this.todoSearch,
      required this.todoList});

  FilteredTodosState get state {
    List<Todo> filteredTodos;
    switch (todoFilter.state.filter) {
      case Filter.active:
        filteredTodos =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        filteredTodos =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.todoSearchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearch.state.todoSearchTerm))
          .toList();
    }
    return FilteredTodosState(filteredTodos: filteredTodos);
  }
}
