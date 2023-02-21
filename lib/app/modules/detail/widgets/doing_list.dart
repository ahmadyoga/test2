import 'package:flutter/material.dart';
import 'package:flutter_todo_app2/app/core/utils/extensions.dart';
import 'package:flutter_todo_app2/app/modules/home/controller.dart';
import 'package:get/get.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(
            children: [
              Image.network(
                'https://popi.bwh.harvard.edu/wp-content/uploads/2020/10/Artwork96_a2eaaa3c-d616-40c2-b3ef-11a0f4d094cd-150x150.png',
                fit: BoxFit.cover,
                width: 65.0.wp,
              ),
              Text('Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                  ))
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodos
                  .map(
                    (element) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0.wp,
                        horizontal: 9.0.wp,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey),
                              onChanged: (value) {
                                homeCtrl.doneTodo(element['title']);
                              },
                              value: element['done'],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              if (homeCtrl.doingTodos.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
            ],
          ));
  }
}
