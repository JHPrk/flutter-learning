// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider_state_notifier_ex/providers/bg_color.dart';
import 'package:state_notifier/state_notifier.dart';

class CounterState extends Equatable {
  final int counter;

  const CounterState({required this.counter});

  @override
  List<Object> get props => [counter];

  @override
  bool get stringify => true;

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}

class Counter extends StateNotifier<CounterState> with LocatorMixin {
  Counter() : super(const CounterState(counter: 0));

  void increament() {
    print(read<BgColor>().state);
    Color currentColor = read<BgColor>().state.color;

    if (currentColor == Colors.blue) {
      state = state.copyWith(counter: state.counter + 1);
    } else if (currentColor == Colors.black) {
      state = state.copyWith(counter: state.counter + 10);
    } else {
      state = state.copyWith(counter: state.counter - 10);
    }
  }

  @override
  void update(Locator watch) {
    print(
        'in Counter StateNotifier<BgColorState>: ${watch<BgColorState>().color}');
    print('in Counter StateNotifier<BgColor>: ${watch<BgColor>().state.color}');
    super.update(watch);
  }
}
