import 'dart:convert';

import 'package:flutter_todo_app2/app/core/utils/keys.dart';
import 'package:flutter_todo_app2/app/data/models/task.dart';
import 'package:flutter_todo_app2/app/data/services/storage/services.dart';
import 'package:get/get.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    print(_storage.read('tasks'));
    return tasks;
  }

  void writeTask(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
