import 'package:flutter/material.dart';
import 'package:hashplus_flutter/UI/AddTaskPage.dart';
import 'package:hashplus_flutter/models/task_model.dart';
import 'package:hashplus_flutter/services/task.dart';
import 'package:hashplus_flutter/services/task_picker_helper.dart';

/// Controller that holds all business logic for the Tasks page.
///
/// The UI widget sets [onStateChanged] and [onShowSnack] callbacks so the
/// controller can trigger rebuilds and user-facing messages without knowing
/// about the widget tree.
class TasksController {
  TasksController({TaskService? taskService})
    : _taskService = taskService ?? TaskService();

  final TaskService _taskService;

  List<Task> tasks = [];
  bool isLoading = false;
  String? errorMessage;

  // ── callbacks set by the UI ────────────────────────────────────────
  /// Called whenever the task list (or any controller state used by the UI)
  /// changes.  The widget should call `setState` inside this callback.
  VoidCallback? onStateChanged;

  /// Called when a snackbar message should be shown.
  void Function(String message, {Color? backgroundColor, Color? textColor})?
  onShowSnack;

  // ── edit-dialog state ──────────────────────────────────────────────
  TimeOfDay? selectedTime;
  DateTime selectedDate = DateTime.now();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ── helpers ────────────────────────────────────────────────────────

  TimeOfDay? parseDbTime(String? s) {
    if (s == null || s.isEmpty) return null;
    final parts = s.split(':');
    if (parts.length < 2) return null;
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }

  String formatTimeForDb(TimeOfDay t) => TaskService.formatTimeForDb(t);

  InputDecoration fieldDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(
        fontFamily: "Alexandria",
        color: Color(0xFF341F1A),
      ),
      prefixIcon: Icon(icon, color: const Color(0xFF341F1A)),
      filled: true,
      fillColor: const Color(0xFFFFF8E7),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    );
  }

  // ── CRUD wrappers ─────────────────────────────────────────────────

  /// Loads all tasks from the database.
  Future<void> loadTasks() async {
    isLoading = true;
    errorMessage = null;
    onStateChanged?.call();
    try {
      tasks = await _taskService.read();
    } catch (e) {
      errorMessage = "تعذر تحميل المهام، تحقق من الاتصال";
      onShowSnack?.call(errorMessage!);
    } finally {
      isLoading = false;
      onStateChanged?.call();
    }
  }

  /// Deletes a task by [id] and refreshes the list.
  Future<void> deleteTask(int? id) async {
    if (id == null) return;
    try {
      await _taskService.delete(id);
      await loadTasks();
    } catch (e) {
      onShowSnack?.call("حدث خطأ أثناء حذف المهمة: $e");
    }
  }

  /// Toggles the completion status of [t] and refreshes the list.
  Future<void> toggleComplete(Task t) async {
    if (t.id == null) return;
    try {
      await _taskService.toggleComplete(t);
      await loadTasks();
    } catch (e) {
      onShowSnack?.call("حدث خطأ أثناء تحديث المهمة: $e");
    }
  }

  /// Navigates to [AddTaskPage] and refreshes the task list.
  Future<void> addTask(BuildContext context) async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(taskService: _taskService),
      ),
    );

    // The page already saved the task and showed a confirmation dialog.
    if (newTask != null) await loadTasks();
  }

  // ── pickers ───────────────────────────────────────────────────────

  Future<void> pickTime(BuildContext context) async {
    final picked = await TaskPickerHelper.pickTime(
      context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      selectedTime = picked;
      if (!context.mounted) return;
      timeController.text = picked.format(context);
      onStateChanged?.call();
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await TaskPickerHelper.pickDate(
      context,
      initialDate: selectedDate,
    );

    if (picked != null) {
      selectedDate = picked;
      dateController.text = TaskService.formatDateForDb(picked);
      onStateChanged?.call();
    }
  }

  // ── edit task ─────────────────────────────────────────────────────

  /// Shows the edit-task dialog and handles saving.
  Future<void> editTask(int? id, BuildContext context) async {
    if (id == null) {
      onShowSnack?.call(
        "تعذر تحديد المهمة",
        backgroundColor: const Color(0xFFFFF8E7),
        textColor: const Color(0xFF341F1A),
      );
      return;
    }

    final userId = _taskService.currentUserId;

    if (userId == null) {
      onShowSnack?.call(
        "يرجى تسجيل الدخول أولاً",
        backgroundColor: const Color(0xFFFFF8E7),
        textColor: const Color(0xFF341F1A),
      );
      return;
    }

    final currentTask = _prepareEdit(id, context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          "تعديل المهمة",
          style: TextStyle(
            color: Color(0xFF341F1A),
            fontFamily: "Alexandria",
            fontWeight: FontWeight.bold,
          ),
        ),

        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: fieldDecoration(
                    label: "عنوان المهمة",
                    icon: Icons.task_alt,
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: descriptionController,
                  decoration: fieldDecoration(
                    label: "وصف المهمة",
                    icon: Icons.description_outlined,
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: timeController,
                  readOnly: true,
                  onTap: () => pickTime(dialogContext),
                  decoration: fieldDecoration(
                    label: "الوقت",
                    hint: "اضغط لاختيار الوقت",
                    icon: Icons.access_time,
                  ),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () => pickDate(dialogContext),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى اختيار تاريخ المهمة';
                    }
                    return null;
                  },
                  decoration: fieldDecoration(
                    label: 'تاريخ المهمة',
                    hint: 'اضغط لاختيار التاريخ',
                    icon: Icons.calendar_today,
                  ),
                ),
              ],
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text(
              "إلغاء",
              style: TextStyle(
                color: Color(0xFF341F1A),
                fontFamily: "Alexandria",
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCFE1E2),
              foregroundColor: const Color(0xFF341F1A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              try {
                if (selectedTime == null) {
                  onShowSnack?.call("الرجاء اختيار وقت المهمة");
                  return;
                }

                await _taskService.update(
                  currentTask.copyWith(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    time: formatTimeForDb(selectedTime!),
                    date: TaskService.formatDateForDb(selectedDate),
                  ),
                );

                await loadTasks();

                if (!dialogContext.mounted) return;

                Navigator.pop(dialogContext);

                onShowSnack?.call(
                  "تم تعديل المهمة بنجاح",
                  backgroundColor: const Color(0xFFCFE1E2),
                  textColor: const Color(0xFF341F1A),
                );
              } catch (e) {
                onShowSnack?.call("حدث خطأ أثناء تعديل المهمة: $e");
              }
            },
            child: const Text(
              "حفظ",
              style: TextStyle(
                fontFamily: "Alexandria",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Populates text controllers from an existing task for the edit dialog.
  Task _prepareEdit(int id, BuildContext context) {
    final currentTask = tasks.firstWhere(
      (t) => t.id == id,
      orElse: () => throw StateError("Task not found"),
    );

    selectedTime = parseDbTime(currentTask.time);

    final parsedDate = DateTime.tryParse(currentTask.date);
    selectedDate = parsedDate ?? DateTime.now();

    titleController.text = currentTask.title;
    descriptionController.text = currentTask.description;
    timeController.text = selectedTime?.format(context) ?? "";
    dateController.text = parsedDate == null
        ? ""
        : TaskService.formatDateForDb(parsedDate);

    return currentTask;
  }

  /// Disposes text editing controllers.
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    dateController.dispose();
  }
}
