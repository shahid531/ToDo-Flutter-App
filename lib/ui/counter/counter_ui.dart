
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter_bloc/counter_bloc.dart';
import '../../bloc/counter_bloc/counter_event.dart';
import '../../bloc/counter_bloc/counter_state.dart';

class CounterUi extends StatelessWidget {
  const CounterUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<CounterBloc>().add(CounterEvent());
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: BlocSelector<CounterBloc, CounterState, int>(
            selector: (state) {
              return state.count;
            },
            builder: (context, state) {
              return Text('$state');
            },
          ),
        ),
      ),
    );
  }
}

