import 'package:flutter/material.dart';
import 'package:hashplus_flutter/UI/mainpage.dart';
import 'package:hashplus_flutter/services/Auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Auth auth = Auth();

  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _handlelogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await auth.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Mainpage()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("خطأ"),
            content: const Text("البريد الإلكتروني أو كلمة المرور غير صحيحة"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("حسنًا"),
              ),
            ],
          );
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
        alignment: Alignment.bottomCenter,
        color: const Color(0xFFFFF8E7),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'asset/sign_in.png',
                  fit: BoxFit.contain,
                  height: 120,
                  width: 120,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF341F1A),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Alexandria",
                  ),
                ),
                const Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF341F1A),
                    fontFamily: "Alexandria",
                  ),
                ),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = MediaQuery.of(context).size.width;

                    final containerWidth = screenWidth > 500
                        ? 400.0
                        : screenWidth - 40;

                    return Container(
                      width: containerWidth,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                              "أهلا بعودتك..",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF341F1A),
                                fontFamily: "Alexandria",
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'يرجى إدخال البريد الإلكتروني';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'البريد الإلكتروني',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Alexandria',
                                  color: Color(0xFF341F1A),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  color: Color(0xFF341F1A),
                                ),
                                fillColor: const Color(0xFFFFF8E7),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال كلمة المرور';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'كلمة المرور',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Alexandria',
                                  color: Color(0xFF341F1A),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF341F1A),
                                ),
                                fillColor: const Color(0xFFFFF8E7),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Flexible(
                                  child: Text(
                                    "ليس لديك حساب؟",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF341F1A),
                                      fontFamily: "Alexandria",
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _isLoading
                                      ? null
                                      : () {
                                          Navigator.pushNamed(
                                            context,
                                            '/signup',
                                          );
                                        },
                                  child: const Text(
                                    "سجل الآن",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF341F1A),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Alexandria",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFCFE1E2),
                                  foregroundColor: const Color(0xFF341F1A),
                                ),
                                onPressed: _isLoading ? null : _handlelogin,
                                child: _isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Login",
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
