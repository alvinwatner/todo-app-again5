import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app_v5/models/todo.dart';
import 'package:todo_app_v5/ui/common/app_colors.dart';
import 'package:todo_app_v5/ui/common/ui_helpers.dart';
import 'package:todo_app_v5/ui/dialogs/add_todo/add_todo_dialog_model.dart';

class AddTodoDialog extends StackedView<AddTodoDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AddTodoDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddTodoDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Todo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            verticalSpaceMedium,
            Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: viewModel.titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    autofocus: true,
                  ),
                  verticalSpaceMedium,
                  TextFormField(
                    controller: viewModel.descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                horizontalSpaceSmall,
                ElevatedButton(
                  onPressed: () => viewModel.saveTodo(completer),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimaryColor,
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddTodoDialogModel viewModelBuilder(BuildContext context) =>
      AddTodoDialogModel();
}
