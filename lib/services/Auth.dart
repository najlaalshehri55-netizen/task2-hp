import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final supabase = Supabase.instance.client.auth;

  Future<void> signUp(String email, String password) async {
    final response = await supabase.signUp(
      email: email.trim(),
      password: password.trim(),
    );

    if (response.user == null) {
      throw Exception('User was not created');
    }
  }

  Future<void> signIn(String email, String password) async {
    await supabase.signInWithPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<void> signout() async {
    await supabase.signOut();
  }
}
