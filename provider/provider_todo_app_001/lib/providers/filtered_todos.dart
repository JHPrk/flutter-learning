// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import 'package:provider_todo_app_001/models/todo_model.dart';
import 'package:provider_todo_app_001/providers/todo_filter.dart';
import 'package:provider_todo_app_001/providers/todo_list.dart';
import 'package:provider_todo_app_001/providers/todo_search.dart';
import 'package:state_notifier/state_notifier.dart';

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

class FilteredTodos extends StateNotifier<FilteredTodosState>
    with LocatorMixin {
  FilteredTodos() : super(FilteredTodosState.initial());

  @override
  void update(Locator watch) {
    final filter = watch<TodoFilterState>().filter;
    final todoSearchTerm = watch<TodoSearchState>().todoSearchTerm;
    final todos = watch<TodoListState>().todos;
    List<Todo> filteredTodos;
    switch (filter) {
      case Filter.active:
        filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todos;
        break;
    }

    if (todoSearchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where(
              (Todo todo) => todo.desc.toLowerCase().contains(todoSearchTerm))
          .toList();
    }
    state = state.copyWith(filteredTodos: filteredTodos);
    super.update(watch);
  }
}
