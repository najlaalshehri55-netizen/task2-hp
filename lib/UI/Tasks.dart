import 'package:flutter/material.dart';
import 'package:hashplus_flutter/UI/AddTaskPage.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<Map<String, dynamic>> tasks = [
    {
      "title": "المهمة 1",
      "description": "بناء تطبيق باستخدام Flutter",
      "time": "8:00 صباحًا",
      "isCompleted": false,
    },
    {
      "title": "المهمة 2",
      "description": "ممارسة التمارين الرياضية",
      "time": "10:00 صباحًا",
      "isCompleted": false,
    },
    {
      "title": "المهمة 3",
      "description": "تنظيف المنزل",
      "time": "2:00 مساءً",
      "isCompleted": false,
    },
    {
      "title": "المهمة 4",
      "description": "قراءة كتاب",
      "time": "5:00 مساءً",
      "isCompleted": false,
    },
    {
      "title": "المهمة 5",
      "description": "إعداد العشاء",
      "time": "8:00 مساءً",
      "isCompleted": false,
    },
  ];

  void editTask(int index) {
    TextEditingController titleController = TextEditingController(
      text: tasks[index]["title"],
    );

    TextEditingController descriptionController = TextEditingController(
      text: tasks[index]["description"],
    );

    TextEditingController timeController = TextEditingController(
      text: tasks[index]["time"],
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "تعديل المهمة",
          style: TextStyle(
            color: Color(0xFF341F1A),
            fontFamily: "Alexandria",
            fontWeight: FontWeight.bold,
          ),
        ),

        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "عنوان المهمة",
                  labelStyle: const TextStyle(
                    fontFamily: "Alexandria",
                    color: Color(0xFF341F1A),
                  ),
                  prefixIcon: const Icon(
                    Icons.task_alt,
                    color: Color(0xFF341F1A),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFF8E7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "وصف المهمة",
                  labelStyle: const TextStyle(
                    fontFamily: "Alexandria",
                    color: Color(0xFF341F1A),
                  ),
                  prefixIcon: const Icon(
                    Icons.description_outlined,
                    color: Color(0xFF341F1A),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFF8E7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: timeController,
                decoration: InputDecoration(
                  labelText: "الوقت",
                  labelStyle: const TextStyle(
                    fontFamily: "Alexandria",
                    color: Color(0xFF341F1A),
                  ),
                  prefixIcon: const Icon(
                    Icons.access_time,
                    color: Color(0xFF341F1A),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFF8E7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
            onPressed: () {
              setState(() {
                tasks[index] = {
                  "title": titleController.text,
                  "description": descriptionController.text,
                  "time": timeController.text,
                  "isCompleted": tasks[index]["isCompleted"],
                };
              });

              Navigator.pop(context);
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

  Future<void> addTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );

    if (newTask != null && newTask is Map<String, dynamic>) {
      setState(() {
        tasks.add({
          "title": newTask["title"] ?? "",
          "description": newTask["description"] ?? "",
          "time": newTask["time"] ?? "",
          "isCompleted": false,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8E7),

      child: SafeArea(
        child: Column(
          children: [
            // العنوان وزر الإضافة
            Padding(
              padding: const EdgeInsets.all(16.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    "المهام",
                    style: TextStyle(
                      fontSize: 26,
                      color: Color(0xFF341F1A),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Alexandria",
                    ),
                  ),

                  FloatingActionButton(
                    backgroundColor: const Color(0xFFCFE1E2),
                    foregroundColor: const Color(0xFF341F1A),

                    onPressed: addTask,

                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),

            // قائمة المهام
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;

                  final horizontalPadding = screenWidth > 600 ? 40.0 : 16.0;

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),

                    itemCount: tasks.length,

                    itemBuilder: (context, index) {
                      final bool isCompleted =
                          tasks[index]["isCompleted"] ?? false;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),

                        padding: const EdgeInsets.all(16.0),

                        decoration: BoxDecoration(
                          color: isCompleted
                              ? Colors.green
                              : const Color(0xFFFFFFF8),

                          borderRadius: BorderRadius.circular(20),

                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            // معلومات المهمة
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    tasks[index]["title"],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isCompleted
                                          ? Colors.white
                                          : const Color(0xFF341F1A),
                                      fontFamily: "Alexandria",
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    tasks[index]["description"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isCompleted
                                          ? Colors.white
                                          : const Color(0xFF341F1A),
                                      fontFamily: "Alexandria",
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: isCompleted
                                            ? Colors.white
                                            : const Color(0xFF341F1A),
                                      ),

                                      const SizedBox(width: 5),

                                      Text(
                                        tasks[index]["time"],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isCompleted
                                              ? Colors.white
                                              : const Color(0xFF341F1A),
                                          fontFamily: "Alexandria",
                                        ),
                                      ),

                                      if (isCompleted) ...[
                                        const SizedBox(width: 12),

                                        const Text(
                                          "مكتمل",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Alexandria",
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // الأزرار
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                // تعديل
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: isCompleted
                                        ? Colors.white
                                        : const Color(0xFF341F1A),
                                  ),

                                  iconSize: 18,

                                  padding: const EdgeInsets.all(3),

                                  constraints: const BoxConstraints(),

                                  onPressed: () {
                                    editTask(index);
                                  },
                                ),

                                // حذف
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: isCompleted
                                        ? Colors.white
                                        : const Color(0xFF341F1A),
                                  ),

                                  iconSize: 18,

                                  padding: const EdgeInsets.all(3),

                                  constraints: const BoxConstraints(),

                                  onPressed: () {
                                    setState(() {
                                      tasks.removeAt(index);
                                    });
                                  },
                                ),

                                // مكتمل
                                IconButton(
                                  icon: Icon(
                                    isCompleted
                                        ? Icons.check_circle
                                        : Icons.check,
                                    color: isCompleted
                                        ? Colors.white
                                        : const Color(0xFF341F1A),
                                  ),

                                  iconSize: 18,

                                  padding: const EdgeInsets.all(3),

                                  constraints: const BoxConstraints(),

                                  onPressed: () {
                                    setState(() {
                                      tasks[index]["isCompleted"] =
                                          !isCompleted;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
