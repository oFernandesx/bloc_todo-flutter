import 'package:flutter_application_1/model/todo_model.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoModel todo;
  AddTodoEvent(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  final TodoModel todo;
  UpdateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final String todoId;
  DeleteTodoEvent(this.todoId);
}

class ToggleCompleteTodoEvent extends TodoEvent {
  final String todoId;
  ToggleCompleteTodoEvent(this.todoId);
}