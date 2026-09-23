import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  int _selectedIndex = 0;
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16.0),
      // child: ListView.builder(
      //   itemCount: 10, // Number of items in the list
      //   itemBuilder: (context, index) {
      //     return Container(
      //       margin: const EdgeInsets.symmetric(vertical: 8.0),
      //       padding: const EdgeInsets.all(16.0),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(8.0),
      //         boxShadow: [
      //           BoxShadow(
      //             color: Colors.grey.withOpacity(0.5),
      //             spreadRadius: 2,
      //             blurRadius: 5,
      //             offset: const Offset(0, 3), // changes position of shadow
      //           ),
      //         ],
      //       ),
      //       child: Text(
      //         'Item ${index + 1}', // Display item number
      //         style: const TextStyle(fontSize: 18.0),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
