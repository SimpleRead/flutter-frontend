import 'package:flutter/material.dart';
import 'package:simpleread/api.dart';
import 'package:simpleread/auth.dart';
import 'package:simpleread/appbar.dart';
import 'package:simpleread/container.dart';

class SimplereadPreview extends StatefulWidget {
  final SimplereadSharedState sharedState;
  const SimplereadPreview({super.key, sharedState}) : this.sharedState = sharedState;

  @override
  State<SimplereadPreview> createState() => _SimplereadPreviewState(sharedState: sharedState);
}

class _SimplereadPreviewState extends State<SimplereadPreview> {
  final SimplereadSharedState sharedState;

  _SimplereadPreviewState({required SimplereadSharedState sharedState}) :
    this.sharedState = sharedState;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => sharedState.switchPage(SimplereadPage.HOME),
        ),
        centerTitle: true,
        title: SimplereadBar(),
      ),
    );
  }
}
