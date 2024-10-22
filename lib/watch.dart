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
  late BuildContext context;

  _SimplereadWatchState({required SimplereadSharedState sharedState}) :
      this.sharedState = sharedState {
    pageNum = sharedState.progress;
    _bookGuid = sharedState.book!;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    if (_stream == null) {
      initStream(context);
    }
    sendCurrentSlide();
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

  Future<void> sendCurrentSlide() async {
    Slide slide = await getSlide();
    sendPicture(slide);
  }

  Future<void> sendSlideWithPlayer(AudioPlayer player) async {
    Slide slide = await getSlide();
    for (;;) {
      bool shouldBreak = true;
      try {
        await player.setSource(UrlSource(sharedState.token!.makeUri(slide.audioUri)));
        await player.setVolume(0);
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
    Size size = MediaQuery.sizeOf(this.context);
    double ratio = size.width / size.height;
    bool isScreenWide = ratio >= 1.2;
    String uri = sharedState.token!.makeUri(slide.imageUri);
    _controller.add(Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      children: [
        Expanded(
          child: Image.network(uri),
        ),
        Text(slide.text),
      ]
    ));
  }

  Future<void> initStream(BuildContext context) async {
    _controller = new StreamController<Widget>();
    _stream = _controller.stream;
    await sendSlide();
  }
}
