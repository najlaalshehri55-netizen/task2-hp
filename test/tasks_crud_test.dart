import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hashplus_flutter/UI/Tasks.dart';
import 'package:hashplus_flutter/controllers/tasks_controller.dart';
import 'package:hashplus_flutter/models/task_model.dart';
import 'package:hashplus_flutter/services/task.dart';

/// In-memory replacement for [TaskService] so the UI can be exercised
/// without a Supabase backend.
class FakeTaskService implements TaskService {
  final List<Task> store = [];
  int _nextId = 1;

  @override
  String? get currentUserId => 'test-user';

  @override
  Future<Task> create({
    required String title,
    required String description,
    required TimeOfDay time,
    required DateTime date,
  }) async {
    final task = Task(
      id: _nextId++,
      title: title.trim(),
      description: description.trim(),
      time: TaskService.formatTimeForDb(time),
      date: TaskService.formatDateForDb(date),
    );
    store.add(task);
    return task;
  }

  @override
  Future<List<Task>> read() async => List.of(store);

  @override
  Future<void> update(Task task) async {
    final index = store.indexWhere((t) => t.id == task.id);
    if (index == -1) throw StateError('Task ${task.id} not found');
    store[index] = task;
  }

  @override
  Future<void> toggleComplete(Task task) =>
      update(task.copyWith(isCompleted: !task.isCompleted));

  @override
  Future<void> delete(int id) async => store.removeWhere((t) => t.id == id);
}

void main() {
  testWidgets('add, edit, complete and delete a task', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    final service = FakeTaskService();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Tasks(controller: TasksController(taskService: service)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // ── add ─────────────────────────────────────────────────────────
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'مذاكرة');
    await tester.enterText(fields.at(1), 'الفصل الأول');

    await tester.tap(fields.at(2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(fields.at(3));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('حفظ المهمة'));
    await tester.tap(find.text('حفظ المهمة'));
    // The save button's spinner keeps animating behind the confirmation
    // dialog, so pumpAndSettle would never settle here.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('تمت إضافة المهمة بنجاح'), findsOneWidget);
    await tester.tap(find.text('حسناً'));
    await tester.pumpAndSettle();

    expect(service.store, hasLength(1));
    expect(find.text('مذاكرة'), findsOneWidget);
    expect(find.text('الفصل الأول'), findsOneWidget);

    // ── edit ────────────────────────────────────────────────────────
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();
    expect(find.text('تعديل المهمة'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'مذاكرة رياضيات');
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();

    expect(service.store.single.title, 'مذاكرة رياضيات');
    expect(find.text('مذاكرة رياضيات'), findsOneWidget);
    expect(find.text('تم تعديل المهمة بنجاح'), findsOneWidget);

    // ── mark as completed, then back ────────────────────────────────
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();
    expect(service.store.single.isCompleted, isTrue);
    expect(find.text('مكتمل'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.check_circle));
    await tester.pumpAndSettle();
    expect(service.store.single.isCompleted, isFalse);
    expect(find.text('مكتمل'), findsNothing);

    // ── delete ──────────────────────────────────────────────────────
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(service.store, isEmpty);
    expect(find.text('مذاكرة رياضيات'), findsNothing);
  });
}
