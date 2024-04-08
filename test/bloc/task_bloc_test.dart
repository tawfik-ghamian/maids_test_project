import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_maids_project/bloc/task_bloc.dart';
import 'package:test_maids_project/services/task_service.dart';
import 'package:test_maids_project/models/task.dart';

class MockTaskService extends Mock implements TaskService {}

void main() {
  group('TaskBloc', () {
    late TaskBloc taskBloc ;
    late MockTaskService mockTaskService;

    setUp(() {
      mockTaskService = MockTaskService();
      taskBloc = TaskBloc(taskService: mockTaskService);
    });

    test('initial state is empty list', () {
      expect(taskBloc.tasks, []);
    });

    test('fetchTasks updates tasks list', () async {
      final tasks = [Task(id: 1, title: 'Task 1', description: 'Description 1')];
      when(mockTaskService.getTasks()).thenAnswer((_) async => tasks);

      // await taskBloc._fetchTasks();

      expect(taskBloc.tasks, tasks);
    });

    // Add more test cases as needed
  });
}
