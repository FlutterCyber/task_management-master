import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Tasks {
  @HiveField(0)
  String nameOfTask;
  @HiveField(1)
  String description;
  @HiveField(2)
  String startDate;
  @HiveField(3)
  String endDate;
  @HiveField(4)
  String taskGroup;
  @HiveField(5)
  String stateOfTask;


  Tasks(
      {required this.nameOfTask,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.taskGroup,
      required this.stateOfTask});

  Tasks.fromJson(Map<String, dynamic> json)
      : nameOfTask = json["nameOfTask"],
        description = json["description"],
        startDate = json["startDate"],
        endDate = json["endDate"],
        taskGroup = json["taskGroup"],
        stateOfTask = json["stateOfTask"];

  Map<String, dynamic> toJson() => {
        "nameOfTask": nameOfTask,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "taskGroup": taskGroup,
        "stateOfTask": stateOfTask,
      };
}
