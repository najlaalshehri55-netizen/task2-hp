import 'package:flutter/material.dart';
import 'package:hashplus_flutter/controllers/tasks_controller.dart';
import 'package:hashplus_flutter/services/time_arabic.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key, this.controller});

  /// Optional controller, injected in tests; defaults to a real one.
  final TasksController? controller;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  late final TasksController _controller =
      widget.controller ?? TasksController();

  @override
  void initState() {
    super.initState();
    _controller.onStateChanged = () {
      if (mounted) setState(() {});
    };
    _controller.onShowSnack = (message, {backgroundColor, textColor}) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(fontFamily: "Alexandria", color: textColor),
          ),
          backgroundColor: backgroundColor,
        ),
      );
    };
    _controller.loadTasks();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8E7),

      child: SafeArea(
        child: Column(
          children: [
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

                    onPressed: () => _controller.addTask(context),

                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;

                  final horizontalPadding = screenWidth > 600 ? 40.0 : 16.0;

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),

                    itemCount: _controller.tasks.length,

                    itemBuilder: (context, index) {
                      final currentTask = _controller.tasks[index];
                      final bool isCompleted = currentTask.isCompleted;

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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    currentTask.title,
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
                                    currentTask.description,
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
                                        formatDbTimeArabic(currentTask.time),
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

                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
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
                                    _controller.editTask(
                                      currentTask.id,
                                      context,
                                    );
                                  },
                                ),

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
                                    _controller.deleteTask(currentTask.id);
                                  },
                                ),

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
                                    _controller.toggleComplete(currentTask);
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
