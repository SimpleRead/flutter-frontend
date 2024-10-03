import 'package:flutter/material.dart';

import 'package:simpleread/container.dart';

class SimplereadSettings extends StatefulWidget {
  SimplereadSharedState _sharedState;
  SimplereadSettings(SimplereadSharedState sharedState) :
      _sharedState = sharedState;
  @override
  State<SimplereadSettings> createState() =>
      _SimplereadSettingsState(_sharedState);
}

class SettingsState {
  bool ldBellMode = false;
}

class _SimplereadSettingsState extends State<SimplereadSettings> {
  final SimplereadSharedState _sharedState;

  _SimplereadSettingsState(SimplereadSharedState sharedState) :
      _sharedState = sharedState;

  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView(
      children: [
        Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  "Lindamood Bell Mode",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Switch(
                value: _sharedState.settings.ldBellMode,
                onChanged: (bool value) {
                  setState(() {
                    _sharedState.settings.ldBellMode = value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
