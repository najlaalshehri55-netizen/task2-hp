import 'package:fl_chart_flutter/fl_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  Map<DateTime, List<String>> tasks = {
    DateTime(2026, 9, 25): ["دراسة Flutter", "ممارسة الرياضة"],
    DateTime(2026, 9, 26): ["إنهاء المشروع"],
    DateTime(2026, 9, 27): ["مراجعة المهام", "حضور المحاضرة"],
  };

  List<String> getTasksForDay(DateTime day) {
    return tasks[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8E7),
      child: ListView(
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "5",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF341F1A),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "3",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF341F1A),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "مكتملة",
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

          const SizedBox(height: 20),

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

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "60%",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF341F1A),
                      ),
                    ),
                    Text(
                      "3 من 5 مهام",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF341F1A),
                        fontFamily: "Alexandria",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                LinearProgressIndicator(
                  value: 0.6,
                  minHeight: 10,
                  backgroundColor: Color(0xFFFFF8E7),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFCFE1E2)),
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
                  calendarStyle: CalendarStyle(
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
                    children: getTasksForDay(selectedDay).map((task) {
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
                            const Icon(
                              Icons.task_alt,
                              color: Color(0xFF341F1A),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              task,
                              style: const TextStyle(
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
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              width: 18,
                              color: const Color(0xFFCFE1E2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              width: 18,
                              color: const Color(0xFFCFE1E2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 2,
                              width: 18,
                              color: const Color(0xFFCFE1E2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 4,
                              width: 18,
                              color: const Color(0xFFCFE1E2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 6,
                              width: 18,
                              color: const Color(0xFFCFE1E2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 5,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              width: 18,
                              color: const Color(0xFFCFE1E2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 6,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              width: 18,
                              color: const Color(0xFFCFE1E2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "مهام اليوم",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF341F1A),
              fontFamily: "Alexandria",
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Color(0xFFCFE1E2), size: 28),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "دراسة Flutter",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF341F1A),
                        fontFamily: "Alexandria",
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "10:00 صباحًا",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Alexandria",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.radio_button_unchecked,
                  color: Color(0xFF341F1A),
                  size: 28,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ممارسة الرياضة",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF341F1A),
                        fontFamily: "Alexandria",
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "5:00 مساءً",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Alexandria",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
