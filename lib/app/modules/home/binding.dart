import 'package:flutter_todo_app2/app/data/providers/task/provide.dart';
import 'package:flutter_todo_app2/app/data/services/storage/repository.dart';
import 'package:flutter_todo_app2/app/modules/home/controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
