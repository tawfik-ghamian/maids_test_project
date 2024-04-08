import 'package:flutter/material.dart';
import '../bloc/task_bloc.dart';
import '../models/task.dart';

class TaskListScreen extends StatelessWidget {
  final TaskBloc taskBloc;

  const TaskListScreen({Key? key, required this.taskBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_task');
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              taskBloc.logout();
              // Navigate to login screen after logging out
              // For example:
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: taskBloc.tasksStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  onTap: () {
                    // Navigate to the edit task screen when tapping on a task
                    // For example:
                    Navigator.pushNamed(context, '/edit_task', arguments: task);
                  },
                  onLongPress: () {
                    // Delete task on long press
                    taskBloc.deleteTask(task);
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
