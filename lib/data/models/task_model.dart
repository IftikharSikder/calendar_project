class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });
}
