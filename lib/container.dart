import 'package:flutter/material.dart';

import 'package:simpleread/home.dart';
import 'package:simpleread/login.dart';

enum SimplereadPage {
  LOGIN,
  HOME,
}

class SimplereadContainer extends StatefulWidget {
  @override
  State<SimplereadContainer> createState() => _SimplereadContainerState();
}

class _SimplereadContainerState extends State<SimplereadContainer> {
  SimplereadPage _state = SimplereadPage.LOGIN;

  void switchPage(SimplereadPage newPage) {
    setState(() {
      _state = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_state) {
    case SimplereadPage.HOME:
      return SimplereadHome();
    case SimplereadPage.LOGIN: default:
      return SimplereadLogin(switchPage: switchPage);
    }
  }
}
