import 'dart:async';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskBloc {
  final TaskService _taskService;
  final _tasksController = StreamController<List<Task>>();
  final _loggedInController = StreamController<bool>();

  List<Task> _tasks = [];
  bool _isLoggedIn = false;

  Stream<List<Task>> get tasksStream => _tasksController.stream;
  Stream<bool> get isLoggedInStream => _loggedInController.stream;

  bool get isLoggedIn => _isLoggedIn;
  List<Task> get tasks => _tasks;

  TaskBloc({required TaskService taskService}) : _taskService = taskService {
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    _tasks = await _taskService.getTasks();
    _tasksController.sink.add(_tasks);
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    _tasksController.sink.add(_tasks);
  }

  Future<void> deleteTask(Task task) async {
    _tasks.remove(task);
    _tasksController.sink.add(_tasks);
  }

  Future<void> editTask(Task updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      _tasksController.sink.add(_tasks);
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoggedIn = await _taskService.login(email: email, password: password);
    _loggedInController.sink.add(_isLoggedIn);
    return _isLoggedIn;
  }

  void logout() {
    _isLoggedIn = false;
    _loggedInController.sink.add(_isLoggedIn);
  }

  void dispose() {
    _tasksController.close();
    _loggedInController.close();
  }
}
