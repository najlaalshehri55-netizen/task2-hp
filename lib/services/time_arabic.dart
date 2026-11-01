String formatDbTimeArabic(String? s) {
  if (s == null || s.isEmpty) return "";
  final parts = s.split(':');
  if (parts.length < 2) return s;

  final h = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  if (h == null || m == null) return s;

  final period = h >= 12 ? 'مساءً' : 'صباحاً';
  final h12 = (h % 12 == 0) ? 12 : h % 12;

  return '$h12:${m.toString().padLeft(2, '0')} $period';
}
