import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_v5/features/home/home_viewmodel.dart';
import 'package:todo_app_v5/features/home/widgets/todo_item.dart';
import 'package:todo_app_v5/features/home/widgets/profile_avatar.dart';
import 'package:todo_app_v5/ui/common/app_colors.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ProfileAvatar(
                imageUrl: viewModel.userImageUrl,
                onTap: viewModel.navigateToProfile,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTodoList(viewModel, null),
            _buildTodoList(viewModel, false),
            _buildTodoList(viewModel, true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.showAddTodoDialog,
          backgroundColor: kcPrimaryColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTodoList(HomeViewModel viewModel, bool? isCompleted) {
    final todos = viewModel.getFilteredTodos(isCompleted: isCompleted);

    if (viewModel.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    if (todos.isEmpty) {
      return const Center(
        child: Text('No todos found'),
      );
    }

    return ListView.builder(
      key: PageStorageKey(isCompleted?.toString() ?? 'all'),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          key: Key(todo.id),
          todo: todo,
          onToggle: viewModel.toggleTodoStatus,
          onDelete: viewModel.deleteTodo,
        );
      },
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
