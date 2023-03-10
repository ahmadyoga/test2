import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_todo_app2/app/core/utils/extensions.dart';
import 'package:flutter_todo_app2/app/core/values/color.dart';
import 'package:flutter_todo_app2/app/data/models/task.dart';
import 'package:flutter_todo_app2/app/modules/home/controller.dart';
import 'package:flutter_todo_app2/app/modules/home/widgets/add_card.dart';
import 'package:flutter_todo_app2/app/modules/home/widgets/add_dialog.dart';
import 'package:flutter_todo_app2/app/modules/home/widgets/task_card.dart';
import 'package:flutter_todo_app2/app/modules/report/view.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      'My List',
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleteing(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleteing(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleteing(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(task: element),
                                ),
                                child: TaskCard(task: element),
                              ),
                            )
                            .toList(),
                        AddCard()
                      ],
                    ),
                  )
                ],
              ),
            ),
            ReportPage(),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) => Obx(
          () => FloatingActionButton(
            backgroundColor: controller.deleting.value ? Colors.red : blue,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(() => AddDialog(), transition: Transition.downToUp);
              } else {
                EasyLoading.showInfo('Please create your task type');
              }
            },
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
          ),
        ),
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Sucess');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(right: 15.0.wp),
                  child: const Icon(Icons.apps),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(left: 15.0.wp),
                  child: const Icon(Icons.data_usage),
                ),
                label: 'Report',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
