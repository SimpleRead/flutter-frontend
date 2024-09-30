import 'package:flutter/material.dart';
import 'package:simpleread/appbar.dart';

class SimplereadHome extends StatefulWidget {
  const SimplereadHome({super.key});

  @override
  State<SimplereadHome> createState() => _SimplereadHomeState();
}

class _SimplereadHomeState extends State<SimplereadHome> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: SimplereadBar()),
      body: <Widget>[
        /// Home page
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Currently reading:", style: theme.textTheme.titleLarge),
            Text("Recommended:", style: theme.textTheme.titleLarge),
          ]
        ),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                "There are currently no settings",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.settings)),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
