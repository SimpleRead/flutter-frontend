import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:simpleread/api.dart';
import 'package:simpleread/auth.dart';
import 'package:simpleread/load.dart';
import 'package:simpleread/container.dart';

import 'package:audioplayers/audioplayers.dart';

import 'dart:async';

class SimplereadWatch extends StatefulWidget {
  final SimplereadSharedState sharedState;
  const SimplereadWatch({super.key, sharedState}) : this.sharedState = sharedState;

  @override
  State<SimplereadWatch> createState() => _SimplereadWatchState(sharedState: sharedState);
}

class _SimplereadWatchState extends State<SimplereadWatch> {
  final SimplereadSharedState sharedState;
  static AudioPlayer? _player;
  late int pageNum;
  late String book;
  late StreamController<Widget> _controller;
  Stream<Widget>? _stream;

  _SimplereadWatchState({required SimplereadSharedState sharedState}) :
      this.sharedState = sharedState {
    if (_player == null) {
      _player = AudioPlayer();
    }
    pageNum = sharedState.progress;
    book = sharedState.book!;
    _player!.onPlayerComplete.listen((_) {
      if (pageNum < book.length) {
        ++pageNum;
        sendSlide().then((_) => setState(() {}));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_stream == null) {
      initStream(context);
    }
    return LoadingStream(child: _stream);
  }

  Future<Slide> getSlide() async {
    return await sharedState.token!.fetchSlide(book, pageNum);
  }

  Future<void> sendSlide() async {
    Slide slide = await getSlide();
    await _player!.play(UrlSource(sharedState.token!.makeUri(slide.audioUri)));
    sendPicture(slide);
  }

  Future<void> sendPicture(Slide slide) async {
    String uri = sharedState.token!.makeUri(slide.imageUri);
    _controller.add(Image.network(uri));
  }

  Future<void> initStream(BuildContext context) async {
    _controller = new StreamController<Widget>();
    _stream = _controller.stream;
    await sendSlide();
  }
}
