import 'package:equatable/equatable.dart';
import 'package:better_breaks/models/counter_model.dart';

class CounterState extends Equatable {
  final CounterModel counter;

  const CounterState({
    this.counter = const CounterModel(),
  });

  CounterState copyWith({
    CounterModel? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object> get props => [counter];
} 