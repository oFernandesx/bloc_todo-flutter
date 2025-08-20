import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/todo_bloc.dart';
import '../Bloc/todo_event.dart';
import '../Bloc/todo_state.dart';
import '../model/todo_model.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is SucessTodoState) {
            final todos = state.todos;
            if (todos.isEmpty) {
              return const Center(child: Text('Nenhuma tarefa adicionada'));
            }
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) {
                        context.read<TodoBloc>().add(ToggleCompleteTodoEvent(todo.id));
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(todo.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showAddEditDialog(context, todo: todo),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<TodoBloc>().add(DeleteTodoEvent(todo.id));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (state is InicialState) {
            return const Center(child: Text('Nenhuma tarefa adicionada'));
          }
          if (state is ErrorTodoState) {
            return Center(child: Text('Erro: ${state.errorMessage}'));
          }
          return const Center(child: Text('Estado desconhecido'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddEditDialog(context),
      ),
    );
  }

  void _showAddEditDialog(BuildContext context, {TodoModel? todo}) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descriptionController = TextEditingController(text: todo?.description ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(todo == null ? 'Adicionar Tarefa' : 'Editar Tarefa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(todo == null ? 'Adicionar' : 'Atualizar'),
            onPressed: () {
              final title = titleController.text.trim();
              final description = descriptionController.text.trim();
              if (title.isEmpty || description.isEmpty) return;

              if (todo == null) {
                final newTodo = TodoModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: title,
                  description: description,
                );
                context.read<TodoBloc>().add(AddTodoEvent(newTodo));
              } else {
                final updatedTodo = todo.copyWith(
                  title: title,
                  description: description,
                );
                context.read<TodoBloc>().add(UpdateTodoEvent(updatedTodo));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
