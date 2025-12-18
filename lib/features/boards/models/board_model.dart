class BoardModel {
  final String boardId;
  final String title;
  final String? description;
  final String ownerId;
  final DateTime createdAt;
  final bool isArchived;

  BoardModel({
    required this.boardId,
    required this.title,
    this.description,
    required this.ownerId,
    required this.createdAt,
    this.isArchived = false,
  });

  factory BoardModel.fromMap(Map<String, dynamic> data, String documentId) {
    DateTime parseDate(dynamic v) {
      if (v == null) return DateTime.now();
      if (v is DateTime) return v;
      try {
        // some Firestore Timestamp-like objects implement toDate()
        final toDate = (v as dynamic).toDate;
        if (toDate != null) return (v as dynamic).toDate();
      } catch (_) {}
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      return DateTime.now();
    }

    return BoardModel(
      boardId: documentId,
      title: data['title'] as String? ?? 'Untitled Board',
      description: data['description'] as String?,
      ownerId: data['ownerId'] as String? ?? '',
      createdAt: parseDate(data['createdAt']),
      isArchived: data['isArchived'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      if (description != null) 'description': description,
      'ownerId': ownerId,
      'createdAt': createdAt,
      'isArchived': isArchived,
    };
  }

  BoardModel copyWith({
    String? boardId,
    String? title,
    String? description,
    String? ownerId,
    DateTime? createdAt,
    bool? isArchived,
  }) {
    return BoardModel(
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}
