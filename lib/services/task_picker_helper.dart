import 'package:flutter/material.dart';

/// Helper for displaying date and time pickers themed for the MyDay design.
class TaskPickerHelper {
  /// Displays the themed MyDay time picker dialog.
  static Future<TimeOfDay?> pickTime(
    BuildContext context, {
    TimeOfDay? initialTime,
  }) async {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
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
  }

  /// Displays the themed MyDay date picker dialog.
  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2025),
      lastDate: lastDate ?? DateTime(2030),
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
  }
}
