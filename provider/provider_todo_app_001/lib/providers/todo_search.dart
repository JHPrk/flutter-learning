// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TodoSearchState extends Equatable {
  final String todoSearchTerm;
  const TodoSearchState({
    required this.todoSearchTerm,
  });

  factory TodoSearchState.initial() {
    return const TodoSearchState(todoSearchTerm: '');
  }

  @override
  List<Object> get props => [todoSearchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({
    String? todoSearchTerm,
  }) {
    return TodoSearchState(
      todoSearchTerm: todoSearchTerm ?? this.todoSearchTerm,
    );
  }
}

class TodoSearch with ChangeNotifier {
  TodoSearchState _state = TodoSearchState.initial();
  TodoSearchState get state => _state;

  void changeSearchTerm(String searchTerm) {
    _state = _state.copyWith(todoSearchTerm: searchTerm);
    notifyListeners();
  }
}
