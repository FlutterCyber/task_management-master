import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../model/tasks.dart';

Widget oneTaskView({required Tasks task}) {
  return Container(
    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
    margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task.nameOfTask,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Icon(
                    task.taskGroup! == "Work"
                        ? IconlyBold.work
                        : (task.taskGroup! == "Daily Study"
                            ? CupertinoIcons.book_fill
                            : CupertinoIcons.profile_circled),
                    size: 24,
                    color: Colors.pink.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          task.description!,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 17,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.access_time_filled_rounded,
              color: Colors.indigoAccent.shade200,
              size: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "10:00 AM",
              style:
                  TextStyle(fontSize: 13, color: Colors.indigoAccent.shade200),
            ),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.only(left: 4, top: 4, right: 4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff5f33e1).withOpacity(0.1)),
              child: Text(
                "done",
                style: TextStyle(
                    fontSize: 12, color: Colors.indigoAccent.shade200),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
