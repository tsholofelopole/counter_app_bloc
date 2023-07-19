import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;

  CounterState(this.counter);
  @override
  List<Object?> get props => [counter];

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(map['counter']?.toInt() ?? 0);
  }
}

class CounterInitial extends CounterState {
  CounterInitial() : super(0);
}

class IncrementState extends CounterState {
  IncrementState(int counter) : super(counter);
}

class DecrementState extends CounterState {
  DecrementState(int counter) : super(counter);
}
