import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // this matches what your test is trying to run
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center(child: Text('0'))));
  }
}
