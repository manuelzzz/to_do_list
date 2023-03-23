class TotalTasksModel {
  int totalTasks;
  int totalTasksFinish;

  TotalTasksModel({
    required this.totalTasks,
    required this.totalTasksFinish,
  });

  late int totalAvaliableTasks = totalTasks - totalTasksFinish;
}
