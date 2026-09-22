import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                            decoration: InputDecoration(
                              labelText: 'اسم المستخدم',
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
                            obscureText: true,
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
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
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

                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgot-password');
                            },
                            child: const Text(
                              "نسيت كلمة المرور؟",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF341F1A),
                                fontFamily: "Alexandria",
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFCFE1E2),
                                foregroundColor: const Color(0xFF341F1A),
                              ),
                              onPressed: () {},
                              child: const Text(
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
