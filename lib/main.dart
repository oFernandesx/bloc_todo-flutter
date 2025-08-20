import 'package:flutter/material.dart';
import 'package:flutter_application_1/Bloc/todo_bloc.dart';
import 'package:flutter_application_1/ui/screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => TodoBloc()),
      ], 
      child: App())
  );
}

class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoScreen(),
    );
  }
}