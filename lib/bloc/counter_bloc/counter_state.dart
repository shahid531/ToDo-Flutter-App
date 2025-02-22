import 'package:equatable/equatable.dart';

class CounterState extends Equatable{
  int count;

  CounterState({required this.count});

  @override

  List<Object?> get props => [count];
}