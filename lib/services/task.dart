import 'package:flutter/material.dart';
import 'package:hashplus_flutter/models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles all task operations against the Supabase `tasks` table.
///
/// Every method throws on failure so the UI can show an error message.
class TaskService {
  static const String _table = 'tasks';
  static const String notLoggedInMessage = 'يرجى تسجيل الدخول أولاً';

  final SupabaseClient _supabase = Supabase.instance.client;

  String? get currentUserId => _supabase.auth.currentUser?.id;

  String _requireUserId() {
    final userId = currentUserId;
    if (userId == null) throw Exception(notLoggedInMessage);
    return userId;
  }

  // ── formatting helpers ───────────────────────────────────────────

  /// Formats a [TimeOfDay] as `HH:mm:00` for the database.
  static String formatTimeForDb(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m:00';
  }

  /// Formats a [DateTime] as `YYYY-MM-DD` for the database.
  static String formatDateForDb(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  // ── CRUD ─────────────────────────────────────────────────────────

  /// Inserts a new task for the current user and returns the saved row.
  Future<Task> create({
    required String title,
    required String description,
    required TimeOfDay time,
    required DateTime date,
  }) async {
    final userId = _requireUserId();

    final newTask = Task(
      title: title.trim(),
      description: description.trim(),
      time: formatTimeForDb(time),
      date: formatDateForDb(date),
    );

    final row = await _supabase
        .from(_table)
        .insert({...newTask.toMap(), 'user_id': userId})
        .select()
        .single();

    return Task.fromMap(row);
  }

  /// Returns all tasks of the current user, oldest first.
  Future<List<Task>> read() async {
    final userId = currentUserId;
    if (userId == null) return [];

    final response = await _supabase
        .from(_table)
        .select()
        .eq('user_id', userId)
        .order('id', ascending: true);

    return response.map<Task>((item) => Task.fromMap(item)).toList();
  }

  /// Saves every field of [task] (it must have an id).
  Future<void> update(Task task) async {
    final userId = _requireUserId();
    if (task.id == null) throw ArgumentError('Task id is required to update');

    final data = task.toMap()..remove('id');

    await _supabase
        .from(_table)
        .update(data)
        .eq('id', task.id!)
        .eq('user_id', userId);
  }

  /// Flips the completion state of [task].
  Future<void> toggleComplete(Task task) {
    return update(task.copyWith(isCompleted: !task.isCompleted));
  }

  Future<void> delete(int id) async {
    final userId = _requireUserId();
    await _supabase.from(_table).delete().eq('id', id).eq('user_id', userId);
  }
}
