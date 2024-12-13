import 'package:todo_app_v5/models/todo.dart';

class HomeRepository {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<List<Todo>> loadTodos() async {
    // In a real app, this would load from a database or API
    await Future.delayed(const Duration(seconds: 1));
    return _todos;
  }

  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
  }
}
