import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_manager/features/subtasks/models/subtask_model.dart';

class SubtaskService {
  final FirebaseFirestore _firestore;

  SubtaskService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _subtaskRef({
    required String boardId,
    required String taskId,
  }) {
    return _firestore
        .collection('boards')
        .doc(boardId)
        .collection('tasks')
        .doc(taskId)
        .collection('subtasks');
  }

  /// CREATE
  Future<SubtaskModel> createSubtask({
    required String boardId,
    required String taskId,
    required String title,
  }) async {
    final docRef = _subtaskRef(
      boardId: boardId,
      taskId: taskId,
    ).doc();

    await docRef.set({
      'title': title,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final snapshot = await docRef.get();

    return SubtaskModel.fromMap(snapshot.data()!, snapshot.id);
  }

  /// READ (single)
  Future<SubtaskModel?> getSubtaskById({
    required String boardId,
    required String taskId,
    required String subtaskId,
  }) async {
    final doc = await _subtaskRef(
      boardId: boardId,
      taskId: taskId,
    ).doc(subtaskId).get();

    if (!doc.exists || doc.data() == null) return null;

    return SubtaskModel.fromMap(doc.data()!, doc.id);
  }

  /// READ (all subtasks for a task)
  Stream<List<SubtaskModel>> streamSubtasks({
    required String boardId,
    required String taskId,
  }) {
    return _subtaskRef(
      boardId: boardId,
      taskId: taskId,
    )
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SubtaskModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  /// UPDATE (title / completed)
  Future<void> updateSubtask({
    required String boardId,
    required String taskId,
    required String subtaskId,
    String? title,
    bool? completed,
  }) async {
    final updateData = <String, dynamic>{};

    if (title != null) updateData['title'] = title;

    if (completed != null) {
      updateData['completed'] = completed;
      updateData['completedAt'] =
          completed ? FieldValue.serverTimestamp() : null;
    }

    if (updateData.isEmpty) return;

    await _subtaskRef(
      boardId: boardId,
      taskId: taskId,
    ).doc(subtaskId).update(updateData);
  }

  /// DELETE
  Future<void> deleteSubtask({
    required String boardId,
    required String taskId,
    required String subtaskId,
  }) async {
    await _subtaskRef(
      boardId: boardId,
      taskId: taskId,
    ).doc(subtaskId).delete();
  }
}
