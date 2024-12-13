import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app_v5/app/app.bottomsheets.dart';
import 'package:todo_app_v5/app/app.dialogs.dart';
import 'package:todo_app_v5/app/app.locator.dart';
import 'package:todo_app_v5/models/todo.dart';
import 'package:todo_app_v5/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<Todo> get todos => _todoService.todos;

  Future<void> initialize() async {
    await runBusyFuture(_todoService.loadTodos());
  }

  Future<void> addTodo() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Add Todo',
      description: 'Add a new todo item',
    );

    if (result?.confirmed ?? false) {
      await _todoService.addTodo(result?.data as Todo);
      rebuildUi();
    }
  }

  Future<void> toggleTodoStatus(String todoId) async {
    await _todoService.toggleTodoStatus(todoId);
    rebuildUi();
  }

  Future<void> deleteTodo(String todoId) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      await _todoService.deleteTodo(todoId);
      rebuildUi();
    }
  }

  List<Todo> getFilteredTodos({bool? isCompleted}) {
    if (isCompleted == null) return todos;
    return todos.where((todo) => todo.isCompleted == isCompleted).toList();
  }
}
