 
class TaskModel {
  final String taskId;
  final String taskBoardId;
  final String? taskBoardTitle;
  final String taskOwnerId;
  final String taskOwnerName;

  final String taskAssignedBy;
  final String taskAssignedTo;

  final DateTime taskCreatedAt;
  final DateTime? taskDeletedAt;
  final bool taskIsDeleted;
  final String taskTitle;
  final String taskDescription;

  final DateTime? taskDeadline;

  final bool taskIsDone;
  final DateTime? taskIsDoneAt;

  TaskModel({
    required this.taskId,
    required this.taskBoardId,
    this.taskBoardTitle,
    required this.taskOwnerId,
    required this.taskOwnerName,
    required this.taskAssignedBy,
    required this.taskAssignedTo,
    required this.taskCreatedAt,
    this.taskDeletedAt,
    this.taskIsDeleted = false,
    required this.taskTitle,
    required this.taskDescription,
    this.taskDeadline,
    this.taskIsDone = false,
    this.taskIsDoneAt,
  });

  factory TaskModel.fromMap(Map<String, dynamic> data, String documentId) {
    DateTime parseDate(dynamic v) {
      if (v == null) return DateTime.now();
      if (v is DateTime) return v;
      try {
        final toDate = (v as dynamic).toDate;
        if (toDate != null) return (v as dynamic).toDate();
      } catch (_) {}
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      return DateTime.now();
    }

    DateTime? parseNullableDate(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      try {
        final toDate = (v as dynamic).toDate;
        if (toDate != null) return (v as dynamic).toDate();
      } catch (_) {}
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      return null;
    }

    return TaskModel(
      taskId: documentId,
      taskBoardId: data['taskBoardId'] as String? ?? '',
      taskBoardTitle: data['taskBoardTitle'] as String?,
      taskOwnerId: data['taskOwnerId'] as String? ?? '',
      taskOwnerName: data['taskOwnerName'] as String? ?? 'Unknown',
      taskAssignedBy: data['taskAssignedBy'] as String? ?? 'None',
      taskAssignedTo: data['taskAssignedTo'] as String? ?? 'None',
      taskCreatedAt: parseDate(data['taskCreatedAt']),
      taskDeletedAt: parseNullableDate(data['taskDeletedAt']),
      taskIsDeleted: data['taskIsDeleted'] as bool? ?? false,
      taskTitle: data['taskTitle'] as String? ?? 'Untitled Task',
      taskDescription: data['taskDescription'] as String? ?? '',
      taskDeadline: parseNullableDate(data['taskDeadline']),
      taskIsDone: data['taskIsDone'] as bool? ?? false,
      taskIsDoneAt: parseNullableDate(data['taskIsDoneAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskBoardId': taskBoardId,
      if (taskBoardTitle != null) 'taskBoardTitle': taskBoardTitle,
      'taskOwnerId': taskOwnerId,
      'taskOwnerName': taskOwnerName,
      'taskAssignedBy': taskAssignedBy,
      'taskAssignedTo': taskAssignedTo,
      'taskCreatedAt': taskCreatedAt,
      if (taskDeletedAt != null) 'taskDeletedAt': taskDeletedAt!,
      'taskIsDeleted': taskIsDeleted,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      if (taskDeadline != null) 'taskDeadline': taskDeadline!,
      'taskIsDone': taskIsDone,
      if (taskIsDoneAt != null) 'taskIsDoneAt': taskIsDoneAt!,
    };
  }

  TaskModel copyWith({
    String? taskId,
    String? taskBoardId,
    String? taskBoardTitle,
    String? taskOwnerId,
    String? taskOwnerName,
    String? taskAssignedBy,
    String? taskAssignedTo,
    DateTime? taskCreatedAt,
    DateTime? taskDeletedAt,
    bool? taskIsDeleted,
    String? taskTitle,
    String? taskDescription,
    DateTime? taskDeadline,
    bool? taskIsDone,
    DateTime? taskIsDoneAt,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      taskBoardId: taskBoardId ?? this.taskBoardId,
      taskBoardTitle: taskBoardTitle ?? this.taskBoardTitle,
      taskOwnerId: taskOwnerId ?? this.taskOwnerId,
      taskOwnerName: taskOwnerName ?? this.taskOwnerName,
      taskAssignedBy: taskAssignedBy ?? this.taskAssignedBy,
      taskAssignedTo: taskAssignedTo ?? this.taskAssignedTo,
      taskCreatedAt: taskCreatedAt ?? this.taskCreatedAt,
      taskDeletedAt: taskDeletedAt ?? this.taskDeletedAt,
      taskIsDeleted: taskIsDeleted ?? this.taskIsDeleted,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      taskDeadline: taskDeadline ?? this.taskDeadline,
      taskIsDone: taskIsDone ?? this.taskIsDone,
      taskIsDoneAt: taskIsDoneAt ?? this.taskIsDoneAt,
    );
  }
}
