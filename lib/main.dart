import 'package:flutter/material.dart';
import 'bloc/task_bloc.dart';
import 'models/task.dart';
import 'screens/add_task_screen.dart';
import 'screens/edit_task_screen.dart';
import 'screens/login_screen.dart';
import 'screens/task_list_screen.dart';
import 'services/auth_service.dart';
import 'services/task_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final taskService = TaskService();
    final taskBloc = TaskBloc(taskService: taskService);

    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(taskBloc: taskBloc),
        '/tasks': (context) => TaskListScreen(taskBloc: taskBloc),
        '/add_task': (context) => AddTaskScreen(taskBloc: taskBloc),
        '/edit_task': (context) => EditTaskScreen(
              taskBloc: taskBloc,
              task: Task(id: 1, title: 'new', description: 'description'),
            ),
      },
    );
  }
}
