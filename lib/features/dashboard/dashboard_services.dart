import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_manager/features/dashboard/models/dashboard_model.dart';

class DashboardService {
  final FirebaseFirestore _firestore;

  DashboardService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Reference to the dashboards collection
  CollectionReference<Map<String, dynamic>> get _dashboardRef =>
      _firestore.collection('dashboards');

  /// CREATE
  Future<DashboardModel> createDashboard({
    required String name,
    Map<String, dynamic>? data,
  }) async {
    final docRef = await _dashboardRef.add({
      'name': name,
      'data': data,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final snapshot = await docRef.get();

    return DashboardModel.fromMap(
      snapshot.data()!,
      snapshot.id,
    );
  }

  /// READ (single)
  Future<DashboardModel?> getDashboardById(String dashboardId) async {
    final doc = await _dashboardRef.doc(dashboardId).get();

    if (!doc.exists || doc.data() == null) return null;

    return DashboardModel.fromMap(doc.data()!, doc.id);
  }

  /// READ (all)
  Stream<List<DashboardModel>> streamDashboards() {
    return _dashboardRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => DashboardModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// UPDATE
  Future<void> updateDashboard(DashboardModel dashboard) async {
    await _dashboardRef.doc(dashboard.dashboardId).update(
          dashboard.toMap(),
        );
  }

  /// DELETE
  Future<void> deleteDashboard(String dashboardId) async {
    await _dashboardRef.doc(dashboardId).delete();
  }
}
