import 'package:flutter/material.dart';
import 'package:hashplus_flutter/services/Auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

Auth auth = Auth();

class _settingsState extends State<settings> {
  bool notificationsEnabled = true;
  bool remindersEnabled = true;

  String get userEmail =>
      Supabase.instance.client.auth.currentUser?.email ?? "غير متوفر";

  BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
    ],
  );

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color(0xFF341F1A),
          fontFamily: "Alexandria",
        ),
      ),
    );
  }

  Widget switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF341F1A),
      activeTrackColor: const Color(0xFFCFE1E2),
      secondary: Icon(icon, color: const Color(0xFF341F1A)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF341F1A),
          fontFamily: "Alexandria",
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xFF341F1A),
          fontFamily: "Alexandria",
          fontSize: 12,
        ),
      ),
    );
  }

  Widget infoTile({
    required IconData icon,
    required String title,
    String? trailingText,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF341F1A)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF341F1A),
          fontFamily: "Alexandria",
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      trailing: trailingText == null
          ? const Icon(Icons.chevron_left, color: Color(0xFF341F1A))
          : Text(
              trailingText,
              style: const TextStyle(
                color: Color(0xFF341F1A),
                fontFamily: "Alexandria",
                fontSize: 13,
              ),
            ),
    );
  }

  void showAbout() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          "حول التطبيق",
          style: TextStyle(
            color: Color(0xFF341F1A),
            fontFamily: "Alexandria",
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "MyDay\nالإصدار 1.0.0\nنظّم يومك وتابع إنجازك",
          style: TextStyle(color: Color(0xFF341F1A), fontFamily: "Alexandria"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      "الإعدادات",
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF341F1A),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Alexandria",
                      ),
                    ),

                    const SizedBox(height: 20),

                    // الحساب
                    sectionTitle("الحساب"),
                    Container(
                      decoration: cardDecoration,
                      child: infoTile(
                        icon: Icons.person_outline,
                        title: "البريد الإلكتروني",
                        trailingText: userEmail,
                      ),
                    ),

                    const SizedBox(height: 20),

                    sectionTitle("عام"),
                    Container(
                      decoration: cardDecoration,
                      child: Column(
                        children: [
                          infoTile(
                            icon: Icons.language,
                            title: "اللغة",
                            trailingText: "العربية",
                          ),
                          const Divider(height: 1),
                          infoTile(
                            icon: Icons.info_outline,
                            title: "حول التطبيق",
                            onTap: showAbout,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCFE1E2),
                  foregroundColor: const Color(0xFF341F1A),
                ),
                onPressed: () async {
                  await auth.signout();

                  if (!context.mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    color: Color(0xFF341F1A),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Alexandria",
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
