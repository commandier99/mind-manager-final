import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_manager/features/dashboard/models/dashboard_model.dart';

class DashboardService {
  final FirebaseFirestore _firestore;

  DashboardService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _dashboardRef =>
      _firestore.collection('dashboards');

  /// CREATE
  Future<DashboardModel> createDashboard({
    required String name,
    Map<String, dynamic>? data,
  }) async {
    final docRef = _dashboardRef.doc();

    await docRef.set({
      'name': name,
      if (data != null) 'data': data,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final snapshot = await docRef.get();

    return DashboardModel.fromMap(snapshot.data()!, snapshot.id);
  }

  /// READ (single)
  Future<DashboardModel?> getDashboardById(String dashboardId) async {
    final doc = await _dashboardRef.doc(dashboardId).get();
    if (!doc.exists || doc.data() == null) return null;
    return DashboardModel.fromMap(doc.data()!, doc.id);
  }

  /// READ (all dashboards)
  Stream<List<DashboardModel>> streamDashboards() {
    return _dashboardRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => DashboardModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  /// UPDATE (does NOT overwrite createdAt)
  Future<void> updateDashboard({
    required String dashboardId,
    String? name,
    Map<String, dynamic>? data,
  }) async {
    final updateData = <String, dynamic>{};

    if (name != null) updateData['name'] = name;
    if (data != null) updateData['data'] = data;

    if (updateData.isEmpty) return;

    await _dashboardRef.doc(dashboardId).update(updateData);
  }

  /// DELETE
  Future<void> deleteDashboard(String dashboardId) async {
    await _dashboardRef.doc(dashboardId).delete();
  }
}
