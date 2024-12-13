import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app_v5/models/todo.dart';

class AddTodoDialogModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveTodo(Function(DialogResponse) completer) {
    if (formKey.currentState!.validate()) {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: titleController.text,
        description: descriptionController.text,
        createdAt: DateTime.now(),
      );

      completer(DialogResponse(confirmed: true, data: todo));
    }
  }
}
