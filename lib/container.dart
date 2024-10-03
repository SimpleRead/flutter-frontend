import 'package:flutter/material.dart';

import 'package:simpleread/api.dart';
import 'package:simpleread/home.dart';
import 'package:simpleread/auth.dart';
import 'package:simpleread/login.dart';
import 'package:simpleread/preview.dart';
import 'package:simpleread/settings.dart';

enum SimplereadPage {
  LOGIN,
  HOME,
  PREVIEW_EXPERIENCE,
  PREVIEW_BOOK,
}

class SimplereadContainer extends StatefulWidget {
  @override
  State<SimplereadContainer> createState() => _SimplereadContainerState();
}

class SimplereadSharedState {
  void Function(SimplereadPage) _switchPage;
  SimplereadPage Function() _getPage;
  late SettingsState settings;
  SimplereadSharedState({
      required void Function(SimplereadPage) switchPage,
      required SimplereadPage Function() getPage,
    }) :
      this._switchPage = switchPage,
      this._getPage = getPage {
    this.settings = new SettingsState();
  }
  AuthToken? token;
  String? book;
  Experience? experience;

  void switchPage(SimplereadPage newPage) {
    this._switchPage(newPage);
  }

  SimplereadPage get currPage => _getPage();
}

class _SimplereadContainerState extends State<SimplereadContainer> {
  late SimplereadSharedState _sharedState;
  SimplereadPage _currPage = SimplereadPage.LOGIN;

  _SimplereadContainerState() {
    this._sharedState = new SimplereadSharedState(
      switchPage: switchPage,
      getPage: () => _currPage,
    );
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
      return SimplereadHome(sharedState: _sharedState);
    case SimplereadPage.PREVIEW_EXPERIENCE:
    case SimplereadPage.PREVIEW_EXPERIENCE:
      return SimplereadPreview(sharedState: _sharedState);
    case SimplereadPage.LOGIN:
    default:
      return SimplereadLogin(sharedState: _sharedState);
    }
  }
}
