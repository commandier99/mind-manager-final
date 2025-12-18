import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_manager/features/user/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _userRef =>
      _firestore.collection('users');

  /// CREATE (only once per user)
  Future<UserModel> createUser({
    required String userId,
    String? name,
    String? email,
  }) async {
    final docRef = _userRef.doc(userId);

    await docRef.set({
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    final snapshot = await docRef.get();
    return UserModel.fromMap(snapshot.data()!, snapshot.id);
  }

  /// READ (single)
  Future<UserModel?> getUserById(String userId) async {
    final doc = await _userRef.doc(userId).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromMap(doc.data()!, doc.id);
  }

  /// STREAM (real-time user)
  Stream<UserModel?> streamUser(String userId) {
    return _userRef.doc(userId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromMap(doc.data()!, doc.id);
    });
  }

  /// UPDATE (does NOT touch createdAt)
  Future<void> updateUser({
    required String userId,
    String? name,
    String? email,
  }) async {
    final updateData = <String, dynamic>{};

    if (name != null) updateData['name'] = name;
    if (email != null) updateData['email'] = email;

    if (updateData.isEmpty) return;

    await _userRef.doc(userId).update(updateData);
  }

  /// DELETE (rare — usually handled by auth lifecycle)
  Future<void> deleteUser(String userId) async {
    await _userRef.doc(userId).delete();
  }
}
