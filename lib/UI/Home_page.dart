import 'package:fl_chart_flutter/fl_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hashplus_flutter/models/task_model.dart';
import 'package:hashplus_flutter/services/task.dart';
import 'package:hashplus_flutter/services/time_arabic.dart';
import 'package:table_calendar/table_calendar.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final TaskService tasks1 = TaskService();
  List<Task> tasks = [];
  @override
  void initState() {
    super.initState();
    gettask();
  }

  List<BarChartGroupData> weeklyBars() {
    final today = DateTime.now();
    return List.generate(7, (i) {
      final day = today.subtract(Duration(days: 6 - i));
      final count = getTasksForDay(
        day,
      ).where((t) => t.isCompleted).length;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: count.toDouble(),
            width: 18,
            color: const Color(0xFFCFE1E2),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  List<Task> getTasksForDay(DateTime day) {
    return tasks.where((t) {
      final d = DateTime.tryParse(t.date);
      return d != null && isSameDay(d, day);
    }).toList();
  }

  List<Task> get todayTasks => getTasksForDay(DateTime.now());

  int get todaytotalCount => todayTasks.length;

  int get todaycompletedCount =>
      todayTasks.where((t) => t.isCompleted).length;

  double get todayprogress =>
      todaytotalCount == 0 ? 0 : todaycompletedCount / todaytotalCount;

  ///////
  int get totalCount => tasks.length;

  int get completedCount => tasks.where((t) => t.isCompleted).length;

  double get progress => totalCount == 0 ? 0 : completedCount / totalCount;
  Future<void> gettask() async {
    try {
      final result = await tasks1.read();
      if (!mounted) return;
      setState(() {
        tasks = result;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تعذر تحميل المهام، تحقق من الاتصال")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8E7),
      child: RefreshIndicator(
        color: const Color(0xFF341F1A),
        backgroundColor: const Color(0xFFCFE1E2),
        onRefresh: gettask,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 10),

            const Text(
              "لوحة المهام",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFF341F1A),
                fontFamily: "Alexandria",
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "نظّم يومك وتابع إنجازك",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF341F1A),
                fontFamily: "Alexandria",
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.only(left: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCFE1E2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tasks.length.toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF341F1A),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "جميع المهام",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF341F1A),
                            fontFamily: "Alexandria",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCFE1E2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          completedCount.toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF341F1A),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "جميع المهام المكتملة",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF341F1A),
                            fontFamily: "Alexandria",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "انجاز المهام  ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF341F1A),
                      fontFamily: "Alexandria",
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(progress * 100).round()}%",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF341F1A),
                        ),
                      ),
                      Text(
                        "$completedCount من $totalCount مهام",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF341F1A),
                          fontFamily: "Alexandria",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: const Color(0xFFFFF8E7),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFCFE1E2),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.only(left: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCFE1E2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          todaytotalCount.toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF341F1A),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "مهام اليوم",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF341F1A),
                            fontFamily: "Alexandria",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCFE1E2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          todaycompletedCount.toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF341F1A),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "مهام اليوم المكتملة",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF341F1A),
                            fontFamily: "Alexandria",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "تقدمك اليوم",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF341F1A),
                      fontFamily: "Alexandria",
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(todayprogress * 100).round()}%",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF341F1A),
                        ),
                      ),
                      Text(
                        "$todaycompletedCount من $todaytotalCount مهام",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF341F1A),
                          fontFamily: "Alexandria",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: todayprogress,
                    minHeight: 10,
                    backgroundColor: const Color(0xFFFFF8E7),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFCFE1E2),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "إنجاز المهام هذا الأسبوع",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF341F1A),
                      fontFamily: "Alexandria",
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const names = [
                                  'إث',
                                  'ث',
                                  'أر',
                                  'خ',
                                  'ج',
                                  'س',
                                  'أح',
                                ];
                                final day = DateTime.now().subtract(
                                  Duration(days: 6 - value.toInt()),
                                );
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    names[day.weekday - 1],
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF341F1A),
                                      fontFamily: "Alexandria",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: weeklyBars(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "التقويم",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF341F1A),
                      fontFamily: "Alexandria",
                    ),
                  ),

                  const SizedBox(height: 10),

                  TableCalendar(
                    firstDay: DateTime(2025),
                    lastDay: DateTime(2030),
                    focusedDay: focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedDay, day);
                    },
                    onDaySelected: (selected, focused) {
                      setState(() {
                        selectedDay = selected;
                        focusedDay = focused;
                      });
                    },
                    eventLoader: (day) => getTasksForDay(day),
                    calendarStyle: CalendarStyle(
                      markerDecoration: const BoxDecoration(
                        color: Color(0xFF341F1A),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xFFCFE1E2),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: const Color(0xFF341F1A).withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: const TextStyle(
                        color: Color(0xFF341F1A),
                        fontWeight: FontWeight.bold,
                      ),
                      todayTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "مهام هذا اليوم",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF341F1A),
                      fontFamily: "Alexandria",
                    ),
                  ),

                  const SizedBox(height: 10),
                  if (getTasksForDay(selectedDay).isEmpty)
                    const Text(
                      "لا توجد مهام لهذا اليوم",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Alexandria",
                      ),
                    )
                  else
                    Column(
                      children: getTasksForDay(selectedDay).map((t) {
                        final done = t.isCompleted;
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                done ? Icons.check_circle : Icons.task_alt,
                                color: const Color(0xFF341F1A),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  t.title,
                                  style: TextStyle(
                                    color: const Color(0xFF341F1A),
                                    fontFamily: "Alexandria",
                                    decoration: done
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),
                              Text(
                                formatDbTimeArabic(t.time),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF341F1A),
                                  fontFamily: "Alexandria",
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
