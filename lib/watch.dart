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
  late int pageNum;
  Book? _book;
  late String _bookGuid;
  late StreamController<Widget> _controller;
  Stream<Widget>? _stream;

  _SimplereadWatchState({required SimplereadSharedState sharedState}) :
      this.sharedState = sharedState {
    pageNum = sharedState.progress;
    _bookGuid = sharedState.book!;
  }

  @override
  Widget build(BuildContext context) {
    if (_stream == null) {
      initStream(context);
    }
    return LoadingStream(child: _stream);
  }

  Future<Slide> getSlide() async {
    return await sharedState.token!.fetchSlide(_bookGuid, pageNum);
  }

  Future<void> sendSlide() async {
    if (_book == null) {
      _book = await sharedState.token!.fetchBook(_bookGuid);
    }
    AudioPlayer player = AudioPlayer();
    player.onPlayerComplete.listen((_) {
      if (pageNum < _book!.length) {
        ++pageNum;
        sendSlide();
      }
    });
    sendSlideWithPlayer(player).then((_) => setState(() {}));
  }

  Future<void> sendSlideWithPlayer(AudioPlayer player) async {
    Slide slide = await getSlide();
    for (;;) {
      bool shouldBreak = true;
      try {
        await player.setSource(UrlSource(sharedState.token!.makeUri(slide.audioUri)));
        await player.resume();
      } on AudioPlayerException catch (e) {
        continue;
      } on PlatformException catch (e) {
        continue;
      } catch (e) {
        continue;
      }
      break;
    }
    sendPicture(slide);
  }

  Future<void> sendPicture(Slide slide) async {
    String uri = sharedState.token!.makeUri(slide.imageUri);
    /*
    _controller.add(Column(
      children: [
        Image.network(uri),
        Text(slide.text),
      ]
    ));
    */
    _controller.add(Image.network(uri));
  }

  Future<void> initStream(BuildContext context) async {
    _controller = new StreamController<Widget>();
    _stream = _controller.stream;
    await sendSlide();
  }
}
