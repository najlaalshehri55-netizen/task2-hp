import 'package:flutter/material.dart';
import 'package:hashplus_flutter/services/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key, this.taskService});

  /// Optional service, injected in tests; defaults to the Supabase one.
  final TaskService? taskService;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  late final TaskService _taskService = widget.taskService ?? TaskService();
  bool _isSaving = false;

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: const Color(0xFFFFF8E7),
              hourMinuteColor: const Color(0xFFCFE1E2),
              hourMinuteTextColor: const Color(0xFF341F1A),
              dayPeriodColor: const Color(0xFFCFE1E2),
              dayPeriodTextColor: const Color(0xFF341F1A),
              dialBackgroundColor: const Color(0xFFCFE1E2),
              dialHandColor: const Color(0xFF341F1A),
              dialTextColor: const Color(0xFF341F1A),
              entryModeIconColor: const Color(0xFF341F1A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF341F1A),
              onPrimary: Color(0xFFFFF8E7),
              surface: Color(0xFFFFF8E7),
              onSurface: Color(0xFF341F1A),
            ),
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Alexandria',
              bodyColor: const Color(0xFF341F1A),
              displayColor: const Color(0xFF341F1A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF341F1A),
              onPrimary: Color(0xFFFFF8E7),
              surface: Color(0xFFFFF8E7),
              onSurface: Color(0xFF341F1A),
            ),

            datePickerTheme: DatePickerThemeData(
              backgroundColor: const Color(0xFFFFF8E7),
              headerBackgroundColor: const Color(0xFFCFE1E2),
              headerForegroundColor: const Color(0xFF341F1A),
              todayForegroundColor: const WidgetStatePropertyAll(
                Color(0xFF341F1A),
              ),
              todayBorder: const BorderSide(color: Color(0xFF341F1A)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),

            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Alexandria',
              bodyColor: const Color(0xFF341F1A),
              displayColor: const Color(0xFF341F1A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = TaskService.formatDateForDb(picked);
      });
    }
  }

  Future<void> _saveTask() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;
    if (_selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("الرجاء اختيار وقت المهمة")));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final savedTask = await _taskService.create(
        title: _titleController.text,
        description: _descriptionController.text,
        time: _selectedTime!,
        date: _selectedDate,
      );

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text(
            "تم الحفظ",
            style: TextStyle(
              color: Color(0xFF341F1A),
              fontFamily: "Alexandria",
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "تمت إضافة المهمة بنجاح",
            style: TextStyle(
              color: Color(0xFF341F1A),
              fontFamily: "Alexandria",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                "حسناً",
                style: TextStyle(
                  color: Color(0xFF341F1A),
                  fontFamily: "Alexandria",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

      if (!mounted) return;
      Navigator.pop(context, savedTask);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("تعذر حفظ المهمة: $e")));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFE1E2),
        title: const Text(
          "MyDay",
          style: TextStyle(
            color: Color(0xFF341F1A),
            fontWeight: FontWeight.bold,
            fontFamily: "Alexandria",
          ),
        ),
      ),

      body: Container(
        color: const Color(0xFFFFF8E7),

        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),

                      const Text(
                        "إضافة مهمة",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xFF341F1A),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Alexandria",
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "أضف مهمة جديدة إلى يومك",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF341F1A),
                          fontFamily: "Alexandria",
                        ),
                      ),

                      const SizedBox(height: 25),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final containerWidth = constraints.maxWidth > 600
                              ? 500.0
                              : constraints.maxWidth * 0.9;

                          return Center(
                            child: Container(
                              width: containerWidth,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),

                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFF8),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),

                              child: Form(
                                key: _formKey,

                                child: Column(
                                  children: [
                                    const Text(
                                      "تفاصيل المهمة",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF341F1A),
                                        fontFamily: "Alexandria",
                                      ),
                                    ),

                                    const SizedBox(height: 25),

                                    TextFormField(
                                      controller: _titleController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'يرجى إدخال عنوان المهمة';
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'عنوان المهمة',
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Alexandria',
                                          color: Color(0xFF341F1A),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.task_alt,
                                          color: Color(0xFF341F1A),
                                        ),
                                        fillColor: const Color(0xFFFFF8E7),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    TextFormField(
                                      controller: _descriptionController,
                                      maxLines: 3,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'يرجى إدخال وصف المهمة';
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'الوصف',
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Alexandria',
                                          color: Color(0xFF341F1A),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.description_outlined,
                                          color: Color(0xFF341F1A),
                                        ),
                                        fillColor: const Color(0xFFFFF8E7),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    TextFormField(
                                      controller: _timeController,
                                      readOnly: true,
                                      onTap: _pickTime,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'يرجى اختيار وقت المهمة';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'وقت المهمة',
                                        hintText: 'اضغط لاختيار الوقت',
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Alexandria',
                                          color: Color(0xFF341F1A),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.access_time,
                                          color: Color(0xFF341F1A),
                                        ),
                                        fillColor: const Color(0xFFFFF8E7),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    TextFormField(
                                      controller: _dateController,
                                      readOnly: true,
                                      onTap: _pickDate,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'يرجى اختيار تاريخ المهمة';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'تاريخ المهمة',
                                        hintText: 'اضغط لاختيار التاريخ',
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Alexandria',
                                          color: Color(0xFF341F1A),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFF341F1A),
                                        ),
                                        fillColor: const Color(0xFFFFF8E7),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 25),

                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFFCFE1E2,
                                          ),
                                          foregroundColor: const Color(
                                            0xFF341F1A,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                        onPressed: _isSaving ? null : _saveTask,
                                        child: _isSaving
                                            ? const SizedBox(
                                                height: 22,
                                                width: 22,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2.5,
                                                      color: Color(0xFF341F1A),
                                                    ),
                                              )
                                            : const Text(
                                                "حفظ المهمة",
                                                style: TextStyle(
                                                  color: Color(0xFF341F1A),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Alexandria",
                                                  fontSize: 18,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
