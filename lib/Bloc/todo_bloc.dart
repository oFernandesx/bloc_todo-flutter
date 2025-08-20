import 'package:flutter_application_1/Bloc/todo_event.dart';
import 'package:flutter_application_1/Bloc/todo_state.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<TodoModel> _todos = [];

  TodoBloc() : super(InicialState()) {
    on<AddTodoEvent>((event, emit) {
      _todos.add(event.todo);
      emit(SucessTodoState(List.from(_todos)));
    });

    on<UpdateTodoEvent>((event, emit) {
      final index = _todos.indexWhere((t) => t.id == event.todo.id);
      if (index != -1) {
        _todos[index] = event.todo;
        emit(SucessTodoState(List.from(_todos)));
      }
    });

    on<DeleteTodoEvent>((event, emit) {
      _todos.removeWhere((t) => t.id == event.todoId);
      emit(SucessTodoState(List.from(_todos)));
    });

    on<ToggleCompleteTodoEvent>((event, emit) {
      final index = _todos.indexWhere((t) => t.id == event.todoId);
      if (index != -1) {
        final currentTodo = _todos[index];
        _todos[index] = currentTodo.copyWith(isCompleted: !currentTodo.isCompleted);
        emit(SucessTodoState(List.from(_todos)));
      }
    });
  }
}
