import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_manager/features/boards/models/board_model.dart';

class BoardService {
  final FirebaseFirestore _firestore;

  BoardService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _boardRef =>
      _firestore.collection('boards');

  /// CREATE
  Future<BoardModel> createBoard({
    required String title,
    String? description,
    required String ownerId,
  }) async {
    final docRef = _boardRef.doc();

    await docRef.set({
      'title': title,
      if (description != null) 'description': description,
      'ownerId': ownerId,
      'createdAt': FieldValue.serverTimestamp(),
      'isArchived': false,
    });

    final snapshot = await docRef.get();

    return BoardModel.fromMap(snapshot.data()!, snapshot.id);
  }

  /// READ (single)
  Future<BoardModel?> getBoardById(String boardId) async {
    final doc = await _boardRef.doc(boardId).get();
    if (!doc.exists || doc.data() == null) return null;
    return BoardModel.fromMap(doc.data()!, doc.id);
  }

  /// READ (active boards)
  Stream<List<BoardModel>> streamBoardsForOwner(String ownerId) {
    return _boardRef
        .where('ownerId', isEqualTo: ownerId)
        .where('isArchived', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BoardModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  /// READ (archived boards)
  Stream<List<BoardModel>> streamArchivedBoards(String ownerId) {
    return _boardRef
        .where('ownerId', isEqualTo: ownerId)
        .where('isArchived', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BoardModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  /// UPDATE (does NOT touch createdAt)
  Future<void> updateBoard({
    required String boardId,
    String? title,
    String? description,
    bool? isArchived,
  }) async {
    final updateData = <String, dynamic>{};

    if (title != null) updateData['title'] = title;
    if (description != null) updateData['description'] = description;
    if (isArchived != null) updateData['isArchived'] = isArchived;

    if (updateData.isEmpty) return;

    await _boardRef.doc(boardId).update(updateData);
  }

  /// ARCHIVE / UNARCHIVE
  Future<void> setBoardArchived(
    String boardId,
    bool isArchived,
  ) async {
    await _boardRef.doc(boardId).update({
      'isArchived': isArchived,
    });
  }

  /// DELETE
  Future<void> deleteBoard(String boardId) async {
    await _boardRef.doc(boardId).delete();
  }
}
