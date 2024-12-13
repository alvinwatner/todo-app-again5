import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app_v5/app/app.bottomsheets.dart';
import 'package:todo_app_v5/app/app.dialogs.dart';
import 'package:todo_app_v5/app/app.locator.dart';
import 'package:todo_app_v5/app/app.router.dart';
import 'package:todo_app_v5/models/todo.dart';
import 'package:todo_app_v5/services/todo_service.dart';
import 'package:todo_app_v5/services/user_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  List<Todo> get todos => _todoService.todos;
  String? get userImageUrl => _userService.userImageUrl;

  Future<void> initialize() async {
    await runBusyFuture(Future.wait([
      _todoService.loadTodos(),
      _userService.initialize(),
    ]));
  }

  Future<void> showAddTodoDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
      barrierDismissible: true,
    );

    if (response?.confirmed == true && response?.data != null) {
      final todo = response!.data as Todo;
      await _todoService.addTodo(todo);
      rebuildUi();
    }
  }

  Future<void> toggleTodoStatus(String todoId) async {
    await _todoService.toggleTodoStatus(todoId);
    rebuildUi();
  }

  Future<void> deleteTodo(String todoId) async {
    final response = await _dialogService.showDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
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

  Future<void> navigateToProfile() async {
    await _navigationService.navigateTo(Routes.profileView);
  }
}
