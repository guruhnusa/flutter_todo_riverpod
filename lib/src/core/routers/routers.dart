import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sabani_tech_test/src/core/routers/router_name.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/controllers/token_manager_provider.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/pages/login_page.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/pages/otp_page.dart';
import 'package:sabani_tech_test/src/features/authentication/presentation/pages/register_page.dart';
import 'package:sabani_tech_test/src/features/home/domain/models/task_model.dart';
import 'package:sabani_tech_test/src/features/home/presentation/pages/add_task_page.dart';
import 'package:sabani_tech_test/src/features/home/presentation/pages/archive_task_page.dart';
import 'package:sabani_tech_test/src/features/home/presentation/pages/delete_task_page.dart';
import 'package:sabani_tech_test/src/features/home/presentation/pages/edit_task_page.dart';
import 'package:sabani_tech_test/src/features/main/presentation/pages/main_page.dart';

part 'routers.g.dart';

@riverpod
Raw<GoRouter> router(RouterRef ref) {
  return GoRouter(
    initialLocation: RouteName.login,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        name: RouteName.login,
        path: '/login',
        builder: (context, state) => const LoginPage(),
        redirect: (context, state) async {
          final token = await ref.watch(tokenManagerProvider.future);
          final hasToken = await token.isLogin();
          if (hasToken) {
            return RouteName.main;
          } else {
            return RouteName.login;
          }
        },
      ),
      GoRoute(
        name: RouteName.register,
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        name: RouteName.otp,
        path: '/otp',
        builder: (context, state) => const OtpPage(),
      ),
      GoRoute(
        name: RouteName.main,
        path: '/main',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        name: RouteName.deleteTask,
        path: '/deleteTask',
        builder: (context, state) => const DeleteTaskPage(),
      ),
      GoRoute(
        name: RouteName.archiveTask,
        path: '/archiveTask',
        builder: (context, state) => const ArchiveTaskPage(),
      ),
      GoRoute(
        name: RouteName.addTask,
        path: '/addTask',
        builder: (context, state) => const AddTaskPage(),
      ),
      GoRoute(
        name: RouteName.editTask,
        path: '/editTask',
        builder: (context, state) {
          TaskModel task = state.extra as TaskModel;
          return EditTaskPage(task: task);
        },
      ),
    ],
  );
}
