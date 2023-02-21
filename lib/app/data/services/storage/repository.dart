import 'package:flutter_todo_app2/app/data/models/task.dart';
import 'package:flutter_todo_app2/app/data/providers/task/provide.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTask() => taskProvider.readTasks();
  void writeTask(List<Task> tasks) => taskProvider.writeTask(tasks);
}
