import 'package:flutter/material.dart';

class signup_page extends StatelessWidget {
  const signup_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFE1E2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF341F1A)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF341F1A),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Alexandria",
                  ),
                ),

                const Text(
                  "إنشاء حساب",
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              labelStyle: const TextStyle(
                                fontFamily: 'Alexandria',
                                color: Color(0xFF341F1A),
                              ),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
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
                          const SizedBox(height: 16),

                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'تأكيد كلمة المرور',
                              labelStyle: const TextStyle(
                                fontFamily: 'Alexandria',
                                color: Color(0xFF341F1A),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
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
                                  " لديك حساب؟",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF341F1A),
                                    fontFamily: "Alexandria",
                                  ),
                                ),
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: const Text(
                                  "سجل دخولك الآن",
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
                              onPressed: () {},
                              child: const Text(
                                "Sign Up",
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
