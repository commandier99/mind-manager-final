import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_manager/features/tasks/models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore;

  TaskService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _taskRef(String boardId) {
    return _firestore
        .collection('boards')
        .doc(boardId)
        .collection('tasks');
  }

  /// CREATE
  Future<TaskModel> createTask({
    required String boardId,
    required String boardTitle,
    required String ownerId,
    required String ownerName,
    required String assignedBy,
    required String assignedTo,
    required String title,
    required String description,
    DateTime? deadline,
  }) async {
    final docRef = _taskRef(boardId).doc();

    await docRef.set({
      'taskBoardId': boardId,
      'taskBoardTitle': boardTitle,
      'taskOwnerId': ownerId,
      'taskOwnerName': ownerName,
      'taskAssignedBy': assignedBy,
      'taskAssignedTo': assignedTo,
      'taskCreatedAt': FieldValue.serverTimestamp(),
      'taskIsDeleted': false,
      'taskTitle': title,
      'taskDescription': description,
      if (deadline != null) 'taskDeadline': deadline,
      'taskIsDone': false,
    });

    final snapshot = await docRef.get();
    return TaskModel.fromMap(snapshot.data()!, snapshot.id);
  }

  /// READ (single)
  Future<TaskModel?> getTaskById({
    required String boardId,
    required String taskId,
  }) async {
    final doc = await _taskRef(boardId).doc(taskId).get();
    if (!doc.exists || doc.data() == null) return null;
    return TaskModel.fromMap(doc.data()!, doc.id);
  }

  /// READ (active tasks)
  Stream<List<TaskModel>> streamTasks({
    required String boardId,
  }) {
    return _taskRef(boardId)
        .where('taskIsDeleted', isEqualTo: false)
        .orderBy('taskCreatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  /// READ (completed tasks)
  Stream<List<TaskModel>> streamCompletedTasks({
    required String boardId,
  }) {
    return _taskRef(boardId)
        .where('taskIsDeleted', isEqualTo: false)
        .where('taskIsDone', isEqualTo: true)
        .orderBy('taskIsDoneAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  /// UPDATE (content)
  Future<void> updateTask({
    required String boardId,
    required String taskId,
    String? title,
    String? description,
    DateTime? deadline,
    String? assignedTo,
  }) async {
    final updateData = <String, dynamic>{};

    if (title != null) updateData['taskTitle'] = title;
    if (description != null) updateData['taskDescription'] = description;
    if (deadline != null) updateData['taskDeadline'] = deadline;
    if (assignedTo != null) updateData['taskAssignedTo'] = assignedTo;

    if (updateData.isEmpty) return;

    await _taskRef(boardId).doc(taskId).update(updateData);
  }

  /// MARK DONE / UNDONE
  Future<void> setTaskDone({
    required String boardId,
    required String taskId,
    required bool isDone,
  }) async {
    await _taskRef(boardId).doc(taskId).update({
      'taskIsDone': isDone,
      'taskIsDoneAt': isDone ? FieldValue.serverTimestamp() : null,
    });
  }

  /// SOFT DELETE
  Future<void> deleteTask({
    required String boardId,
    required String taskId,
  }) async {
    await _taskRef(boardId).doc(taskId).update({
      'taskIsDeleted': true,
      'taskDeletedAt': FieldValue.serverTimestamp(),
    });
  }

  /// HARD DELETE (rarely needed)
  Future<void> permanentlyDeleteTask({
    required String boardId,
    required String taskId,
  }) async {
    await _taskRef(boardId).doc(taskId).delete();
  }
}
