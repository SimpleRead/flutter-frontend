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

class LoadingStream extends StatefulWidget {
  final Stream<Widget> _stream;
  const LoadingStream({super.key, child}) : this._stream = child;

  @override
  State<LoadingStream> createState() => _LoadingStreamState(stream: _stream);
}

class _LoadingStreamState extends State<LoadingStream> {
  final Stream<Widget> _stream;

  _LoadingStreamState({required Stream<Widget> stream}) : this._stream = stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Widget>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        }
        return Text("Loading...");
      }
    );
  }
}
