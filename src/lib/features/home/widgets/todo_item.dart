import 'package:flutter/material.dart';
import 'package:todo_app_v5/models/todo.dart';
import 'package:todo_app_v5/ui/common/app_colors.dart';
import 'package:todo_app_v5/utils/date_time_utils.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.description),
            const SizedBox(height: 4),
            if (todo.dueDate != null)
              Text(
                'Due: ${formatDateTime(todo.dueDate!)}',
                style: const TextStyle(
                  color: kcPrimaryColor,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => onDelete(todo.id),
        ),
        isThreeLine: todo.dueDate != null,
      ),
    );
  }
}
