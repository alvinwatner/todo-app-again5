import 'package:flutter/material.dart';
import 'package:todo_app_v5/models/todo.dart';
import 'package:todo_app_v5/ui/common/ui_helpers.dart';

class AddTodoForm extends StatefulWidget {
  final Function(Todo) onSubmit;

  const AddTodoForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDueDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        createdAt: DateTime.now(),
        dueDate: _selectedDueDate,
      );
      widget.onSubmit(todo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
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
          ),
          verticalSpaceMedium,
          TextFormField(
            controller: _descriptionController,
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
          verticalSpaceMedium,
          ListTile(
            title: Text(_selectedDueDate == null
                ? 'No due date selected'
                : 'Due date: ${_selectedDueDate.toString().split(' ')[0]}'),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ),
          verticalSpaceMedium,
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Add Todo'),
          ),
        ],
      ),
    );
  }
}
