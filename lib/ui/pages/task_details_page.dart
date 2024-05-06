import 'package:flutter/material.dart';

import '../../model/tasks.dart';

class TaskDetailsPage extends StatelessWidget {
  Tasks tasks;

  TaskDetailsPage({required this.tasks, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Task Details"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                "Name: ${tasks.nameOfTask}",
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "task group: ${tasks.taskGroup}",
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Description: ${tasks.description}",
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Start date: ${tasks.startDate}",
                style: TextStyle(fontSize: 17),
              ),
              Text(
                "End date: ${tasks.endDate}",
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5f33e1),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: const Size(double.infinity, 45)),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
