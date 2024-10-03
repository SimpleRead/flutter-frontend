import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final Future<Widget> _future;
  const LoadingPage({super.key, child}) : this._future = child;

  @override
  State<LoadingPage> createState() => _LoadingPageState(future: _future);
}

class _LoadingPageState extends State<LoadingPage> {
  final Future<Widget> _future;

  _LoadingPageState({required Future<Widget> future}) : this._future = future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        }
        return Text("Loading...");
      }
    );
  }
}
