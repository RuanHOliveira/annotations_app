class Annotation {
  final int? id;
  final int userId;
  final String title;
  final String content;
  final int editCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const Annotation({
    this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.createdAt,
    this.editCount = 0,
    this.updatedAt,
    this.deletedAt,
  });

  Annotation copyWith({
    int? id,
    int? userId,
    String? title,
    String? content,
    int? editCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Annotation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      editCount: editCount ?? this.editCount,
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
      'user_id': userId,
      'title': title,
      'content': content,
      'edit_count': editCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory Annotation.fromMap(Map<String, Object?> map) {
    return Annotation(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      title: (map['title'] as String?) ?? '',
      content: (map['content'] as String?) ?? '',
      editCount: (map['edit_count'] as int?) ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: _parseDate(map['updated_at']),
      deletedAt: _parseDate(map['deleted_at']),
    );
  }
}
