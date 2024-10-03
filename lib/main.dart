import 'package:flutter/material.dart';
import 'package:simpleread/container.dart';

import 'package:simpleread/login.dart';

void main() {
  runApp(const SimplereadApp());
}

class SimplereadApp extends StatelessWidget {
  const SimplereadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: SimplereadContainer(),
      debugShowCheckedModeBanner: false,
    );
  }
}
