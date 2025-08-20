import 'package:flutter_application_1/model/todo_model.dart';

abstract class TodoState {}

class InicialState extends TodoState {}

class LoadingTodoState extends TodoState {}

class ErrorTodoState extends TodoState {
  final String errorMessage;
  ErrorTodoState(this.errorMessage);
}

class SucessTodoState extends TodoState {
  final List<TodoModel> todos;
  SucessTodoState(this.todos);
}