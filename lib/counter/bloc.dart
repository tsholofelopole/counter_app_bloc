import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'event.dart';
import 'state.dart';

class CounterBloc extends HydratedBloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    // on<InitEvent>(_init);
    on<CounterIncrementEvent>((event, emit) {
      emit(IncrementState(state.counter + 1));
    });

    on<CounterDecrementEvent>((event, emit) {
      emit(DecrementState(state.counter - 1));
    });
  }

  void _init(InitEvent event, Emitter<CounterState> emit) async {
    emit(CounterState(0));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }
}
