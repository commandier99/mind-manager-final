class SubtaskModel {
  final String subtaskId;
  final String title;
  final bool completed;
  final DateTime createdAt;
  final DateTime? completedAt;

  SubtaskModel({
    required this.subtaskId,
    required this.title,
    this.completed = false,
    required this.createdAt,
    this.completedAt,
  });

  factory SubtaskModel.fromMap(Map<String, dynamic> data, String documentId) {
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

    return SubtaskModel(
      subtaskId: documentId,
      title: data['title'] as String? ?? 'Untitled',
      completed: data['completed'] as bool? ?? false,
      createdAt: parseDate(data['createdAt']),
      completedAt: parseNullableDate(data['completedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'completed': completed,
      'createdAt': createdAt,
      if (completedAt != null) 'completedAt': completedAt!,
    };
  }

  SubtaskModel copyWith({
    String? subtaskId,
    String? title,
    bool? completed,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return SubtaskModel(
      subtaskId: subtaskId ?? this.subtaskId,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
