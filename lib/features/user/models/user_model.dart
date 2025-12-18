class UserModel {
  final String userId;
  final String? name;
  final String? email;
  final DateTime createdAt;

  UserModel({required this.userId, this.name, this.email, required this.createdAt});

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
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

    return UserModel(
      userId: documentId,
      name: data['name'] as String?,
      email: data['email'] as String?,
      createdAt: parseDate(data['createdAt']),
    );
  }

  Map<String, dynamic> toMap() => {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        'createdAt': createdAt,
      };

  UserModel copyWith({String? userId, String? name, String? email, DateTime? createdAt}) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
