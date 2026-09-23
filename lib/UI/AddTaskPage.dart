import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final pageContext = context;

      showDialog(
        context: pageContext,
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
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pop(pageContext, {
                  "title": _titleController.text,
                  "description": _descriptionController.text,
                  "time": _timeController.text,
                });
              },
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
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
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
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'يرجى إدخال وقت المهمة';
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'وقت المهمة',
                                        hintText: 'مثال: 7:00 مساءً',
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
                                        onPressed: _saveTask,
                                        child: const Text(
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
