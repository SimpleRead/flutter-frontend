import 'package:flutter/material.dart';
import 'package:simpleread/navigator.dart';
import 'package:simpleread/login.dart';

void main() {
  runApp(const SimplereadApp());
}

class SimplereadApp extends StatelessWidget {
  const SimplereadApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const SimplereadLogin(),
    );
  }
}
