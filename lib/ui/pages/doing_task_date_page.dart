import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management_and_to_do_list/ui/pages/task_details_page.dart';
import '../../model/tasks.dart';
import '../../service/hive_db.dart';
import '../classes/type_of_tasks.dart';
import '../widgets/one_task_widget.dart';
import 'bottom_nav_bar.dart';
import 'package:get/get.dart';

class DoingTaskScreen extends StatefulWidget {
  const DoingTaskScreen({super.key});

  @override
  State<DoingTaskScreen> createState() => _DoingTaskScreenState();
}

class _DoingTaskScreenState extends State<DoingTaskScreen> {
  List<String> list1 = ["All", "To do", "In Progress", "Done"];
  String taskType = "All";
  List<TypeOfTasks> list2 = [];

  sortList() {
    if (taskType == "All") {
      setState(() {
        list2 = ListOfTasks.list;
      });
    } else {
      list2 = [];
      for (TypeOfTasks screensCards in ListOfTasks.list) {
        if (screensCards.stateOfTask == taskType) {
          setState(() {
            list2.add(screensCards);
          });
        }
      }
    }
  }

  List<Tasks> projects = [];
  HiveService hiveService = HiveService();

  getSavedTasks(String key) async {
    for (Tasks item in await hiveService.getTasks(key)) {
      setState(() {
        projects.add(item);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sortList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            tileMode: TileMode.clamp,
            radius: 2,
            colors: [
              Colors.white,
              Colors.white,
              Colors.purpleAccent.shade100.withOpacity(0.1),
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.yellowAccent.shade100.withOpacity(0.1),
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.blueAccent.shade100.withOpacity(0.1),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Today's Tasks",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, BottomNavBar.id);
                },
                icon: SvgPicture.asset("assets/images/arrow-left.svg"),
              ),
              actions: [
                SizedBox(
                  height: 56,
                  width: 56,
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/images/notification.svg",
                          height: 28,
                          width: 28,
                        ),
                      ),
                      //If yozish kk notification bulsa chiqadi bulmasa yoq;
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, right: 23),
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              color: const Color(0xff5f33e1),
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                child: EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  onDateChange: (selectedDate) {
                    String key = DateFormat("dd/MM/yyyy").format(selectedDate);
                    setState(() {
                      projects = [];
                    });
                    getSavedTasks(key);
                  },
                  headerProps: const EasyHeaderProps(
                    dateFormatter: DateFormatter.fullDateDMY(),
                  ),
                  dayProps: EasyDayProps(
                    width: 70,
                    height: 90,
                    dayStructure: DayStructure.dayStrDayNumMonth,
                    activeDayStyle: const DayStyle(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Color(0xff5f33e1),
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(
                              color: const Color(0xff5f33e1).withOpacity(0.1),
                              width: 1)),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list1.length + 1,
                  itemBuilder: (context, index) {
                    return index == list1.length
                        ? const SizedBox(width: 24)
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                taskType = list1[index];
                                Future.delayed(
                                    const Duration(milliseconds: 100));
                                sortList();
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 24),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              decoration: BoxDecoration(
                                color: list1[index] == taskType
                                    ? const Color(0xff5f33e1)
                                    : const Color(0xff5f33e1).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                list1[index],
                                style: TextStyle(
                                    color: list1[index] == taskType
                                        ? const Color(0xffeee9ff)
                                        : const Color(0xff5f33e1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
            if (projects.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: projects.length + 1,
                  (context, index) {
                    return index == projects.length
                        ? const SizedBox(
                            height: 40,
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.to(TaskDetailsPage(
                                tasks: projects[index],
                              ));
                            },
                            child: oneTaskView(task: projects[index]),
                          );
                  },
                ),
              ),
            if (projects.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 150),
                  child: SvgPicture.asset(
                    "assets/images/not found image.svg",
                    height: 100,
                    width: 100,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
