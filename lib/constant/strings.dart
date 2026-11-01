import 'package:flutter_dotenv/flutter_dotenv.dart';

String get DBurl {
  final value = dotenv.env['SUPABASE_URL'];
  if (value == null || value.isEmpty) {
    throw StateError('SUPABASE_URL is missing from .env');
  }
  return value;
}

String get DBpublishableKey {
  final value = dotenv.env['SUPABASE_PUBLISHABLE_KEY'];
  if (value == null || value.isEmpty) {
    throw StateError('SUPABASE_PUBLISHABLE_KEY is missing from .env');
  }
  return value;
}

const String welcome_screen = '/';
const String login_screen = '/login';
const String signup_screen = '/signup';
const String home_screen = '/home';
const String task_screen = '/task';
const String edit_task_screen = '/edit_task';
