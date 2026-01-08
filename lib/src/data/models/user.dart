class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    final s = value.toString();
    if (s.trim().isEmpty) return null;
    return DateTime.tryParse(s);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, Object?> map) {
    return User(
      id: map['id'] as int?,
      name: (map['name'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      password: (map['password'] as String?) ?? '',
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: _parseDate(map['updated_at']),
      deletedAt: _parseDate(map['deleted_at']),
    );
  }
}
