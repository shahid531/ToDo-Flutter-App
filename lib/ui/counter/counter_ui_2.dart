import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter_bloc/counter_bloc.dart';

class CounterUi2 extends StatelessWidget {
  const CounterUi2({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CounterBloc>().state;
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text('${state.count}')
        ),
      ),
    );
  }
}
