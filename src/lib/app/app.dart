import 'package:todo_app_v5/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:todo_app_v5/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:todo_app_v5/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import 'package:todo_app_v5/ui/dialogs/add_todo/add_todo_dialog.dart';
import 'package:todo_app_v5/features/home/home_view.dart';
import 'package:todo_app_v5/features/startup/startup_view.dart';
import 'package:todo_app_v5/services/todo_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmDeleteDialog),
    StackedDialog(classType: AddTodoDialog),
  ],
)
class App {}
