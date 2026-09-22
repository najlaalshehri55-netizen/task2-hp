// TODO Implement this library.
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

      body: Padding(
        padding: const EdgeInsets.all(50),

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
                        fontFamily: "Alexandria",
                        fontWeight: FontWeight.bold,

                        fontSize: 30,
                      ),
                    ),

                    const Text(
                      "نظّم مهامك، تابع إنجازك، واستمتع بيوم أكثر تنظيمًا",
                      style: TextStyle(
                        color: Color(0xFF341F1A),
                        fontFamily: "Alexandria",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100),
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
    );
  }
}
