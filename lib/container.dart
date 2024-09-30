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

class SimplereadSharedState {
  void Function(SimplereadPage) _switchPage;
  SimplereadSharedState({required void Function(SimplereadPage) switchPage}) :
    this._switchPage = switchPage;

  void switchPage(SimplereadPage newPage) {
    this._switchPage(newPage);
  }
}

class _SimplereadContainerState extends State<SimplereadContainer> {
  late SimplereadSharedState _sharedState;
  SimplereadPage _currPage = SimplereadPage.LOGIN;

  _SimplereadContainerState() {
    this._sharedState = new SimplereadSharedState(switchPage: switchPage);
  }

  void switchPage(SimplereadPage newPage) {
    setState(() {
      _currPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currPage) {
    case SimplereadPage.HOME:
      return SimplereadHome();
    case SimplereadPage.LOGIN: default:
      return SimplereadLogin(sharedState: _sharedState);
    }
  }
}
