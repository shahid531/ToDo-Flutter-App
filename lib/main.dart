
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/ui/crud_ui/crud_ui.dart';

import 'bloc/counter_bloc/counter_bloc.dart';
import 'bloc/crud_bloc/crud_bloc.dart';
import 'bloc/crud_bloc/crud_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => CrudBloc()..add(CrudLoadEvent())),
      ],
      child:  MaterialApp(
        theme: ThemeData(
          fontFamily: 'Open Sans'
        ),
        home: CrudUi(),
      ),
    );
  }
}
