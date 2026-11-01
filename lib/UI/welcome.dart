import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class welcome extends StatelessWidget {
  const welcome({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),

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

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(w * 0.05),

          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: w * 0.9,
                  height: h * 0.6,

                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 248),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'asset/checklist-custom-image.png',
                          height: h * 0.25,
                          width: h * 0.25,
                        ),

                        const Text(
                          "مرحبا بك في MyDay!",
                          style: TextStyle(
                            color: Color(0xFF341F1A),
                            fontFamily: "Alexandria",
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              color: Color(0xFF341F1A),
                              fontFamily: "Alexandria",
                              fontSize: 25,
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                FadeAnimatedText(
                                  "نظّم مهامك،",
                                  textAlign: TextAlign.right,
                                ),
                                FadeAnimatedText(
                                  "تابع إنجازك،",
                                  textAlign: TextAlign.right,
                                ),
                                FadeAnimatedText(
                                  "واستمتع بيوم أكثر تنظيمًا",
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.04),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCFE1E2),
                  foregroundColor: const Color(0xFF341F1A),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  "Get Started ⭐",
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
