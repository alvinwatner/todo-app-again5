import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app_v5/features/home/widgets/add_todo_form.dart';
import 'package:todo_app_v5/models/todo.dart';

class AddTodoSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const AddTodoSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Add Todo',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          AddTodoForm(
            onSubmit: (Todo todo) {
              completer(SheetResponse(
                confirmed: true,
                data: todo,
              ));
            },
          ),
        ],
      ),
    );
  }
}
