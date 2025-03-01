import 'package:bloc/bloc.dart';
import 'package:better_breaks/blocs/counter/counter_event.dart';
import 'package:better_breaks/blocs/counter/counter_state.dart';
import 'package:better_breaks/models/counter_model.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncremented>(_onIncrement);
    on<CounterDecremented>(_onDecrement);
    on<CounterReset>(_onReset);
  }

  void _onIncrement(CounterIncremented event, Emitter<CounterState> emit) {
    final updatedCounter = state.counter.copyWith(
      value: state.counter.value + 1,
    );
    emit(state.copyWith(counter: updatedCounter));
  }

  void _onDecrement(CounterDecremented event, Emitter<CounterState> emit) {
    final updatedCounter = state.counter.copyWith(
      value: state.counter.value - 1,
    );
    emit(state.copyWith(counter: updatedCounter));
  }

  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    emit(const CounterState());
  }
} 