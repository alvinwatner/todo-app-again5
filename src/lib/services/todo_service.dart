import 'package:todo_app_v5/features/home/home_repository.dart';
import 'package:todo_app_v5/models/todo.dart';

class TodoService {
  final _repository = HomeRepository();

  List<Todo> get todos => _repository.todos;

  Future<List<Todo>> loadTodos() async {
    return await _repository.loadTodos();
  }

  Future<void> addTodo(Todo todo) async {
    await _repository.addTodo(todo);
  }

  Future<void> toggleTodoStatus(String todoId) async {
    final todo = todos.firstWhere((t) => t.id == todoId);
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await _repository.updateTodo(updatedTodo);
  }

  Future<void> deleteTodo(String todoId) async {
    await _repository.deleteTodo(todoId);
  }
}
