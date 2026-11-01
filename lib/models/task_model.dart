/// Data model for a single task row in the Supabase `tasks` table.
class Task {
  final int? id;
  final String title;
  final String description;

  /// Stored as `YYYY-MM-DD`.
  final String date;

  /// Stored as `HH:mm:ss` (column `task_time`).
  final String time;
  final bool isCompleted;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      date: map['date'] as String? ?? '',
      time: map['task_time'] as String? ?? '',
      isCompleted: map['is_completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'date': date,
      'task_time': time,
      'is_completed': isCompleted,
    };
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    String? time,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
