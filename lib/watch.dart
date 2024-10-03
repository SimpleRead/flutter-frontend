import 'package:flutter/material.dart';
import 'package:simpleread/auth.dart';

class SimplereadWatch extends StatefulWidget {
  final SimplereadSharedState sharedState;
  const SimplereadWatch({super.key, sharedState}) : this.sharedState = sharedState;

  @override
  State<SimplereadLogin> createState() => _SimplereadWatchState(sharedState: sharedState);
}

class _SimplereadLoginState extends State<SimplereadLogin> {
  final SimplereadSharedState sharedState;
  static AudioPlayer? _player;

  _SimplereadLoginState({required SimplereadSharedState sharedState}) :
      this.sharedState = sharedState {
    if (_player == null) {
      _player = AudioPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
  }
}
