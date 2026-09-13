import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },

      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            fontFamily: "serif",
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

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
                margin: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    Image.asset(
                      'asset/sun-logo-images-vector.jpg',
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),

                    const Text(
                      "مرحبا بك في MyDay!",
                      style: TextStyle(
                        color: Color(0xFF341F1A),
                        fontFamily: "serif",
                        fontWeight: FontWeight.bold,

                        fontSize: 30,
                      ),
                    ),

                    const Text(
                      "نظّم مهامك، تابع إنجازك، واستمتع بيوم أكثر تنظيمًا",
                      style: TextStyle(
                        color: Color(0xFF341F1A),
                        fontFamily: "serif",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCFE1E2),
                foregroundColor: const Color(0xFF341F1A),
              ),
              onPressed: () {
                print("Button clicked");
              },
              child: const Text(
                "Get Started ⭐",
                style: TextStyle(
                  color: Color(0xFF341F1A),
                  fontWeight: FontWeight.bold,

                  fontFamily: "serif",
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
