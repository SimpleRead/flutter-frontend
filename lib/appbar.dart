import 'package:flutter/material.dart';

class SimplereadBar extends StatefulWidget {
  const SimplereadBar({super.key});

  @override
  State<SimplereadBar> createState() => _SimplereadBarState();
}

class _SimplereadBarState extends State<SimplereadBar> {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage("images/simpleread-sr.png"),
      height: AppBar().preferredSize.height-10,
    );
  }
}
