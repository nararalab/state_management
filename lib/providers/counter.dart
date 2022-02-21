import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

import 'bg_color.dart';

class CounterState extends Equatable {
  final int counter;
  const CounterState({
    required this.counter,
  });

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object> get props => [counter];
}

class Counter extends StateNotifier<CounterState> with LocatorMixin {
  Counter() : super(const CounterState(counter: 0));

  void increment() {
    print(read<BgColor>().state);
    // watch(); 불가능함
    Color currentColor = read<BgColor>().state.color;

    if (currentColor == Colors.black) {
      state = state.copyWith(counter: state.counter + 10);
    } else if (currentColor == Colors.red) {
      state = state.copyWith(counter: state.counter - 10);
    } else {
      state = state.copyWith(counter: state.counter + 1);
    }
  }

  @override
  void update(Locator watch) {
    print('In Counter StateNorifier ${watch<BgColorState>().color}');
    print('In Counter StateNorifier ${watch<BgColor>().state.color}');
    super.update(watch);
  }
}
