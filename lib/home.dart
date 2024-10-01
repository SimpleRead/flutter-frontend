import 'package:flutter/material.dart';
import 'package:simpleread/api.dart';
import 'package:simpleread/auth.dart';
import 'package:simpleread/appbar.dart';
import 'package:simpleread/container.dart';

class SimplereadHome extends StatefulWidget {
  final SimplereadSharedState sharedState;
  const SimplereadHome({super.key, sharedState}) : this.sharedState = sharedState;

  @override
  State<SimplereadHome> createState() => _SimplereadHomeState(sharedState: sharedState);
}

class _SimplereadHomeState extends State<SimplereadHome> {
  int currentPageIndex = 0;
  final SimplereadSharedState sharedState;

  _SimplereadHomeState({required SimplereadSharedState sharedState}) : this.sharedState = sharedState;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AuthToken? token = sharedState.token;
    if (token == null || !token.isValid()) {
      return Text("ERROR: Entered home page with invalid/missing token");
    }
    Future<Homepage> homePage = token!.homePage()!;
    return Scaffold(
      appBar: AppBar(title: SimplereadBar()),
      body: <Widget>[
        /// Home page
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Currently reading:", style: theme.textTheme.titleLarge),
            FutureBuilder<Homepage>(
              future: homePage,
              builder: (BuildContext context, AsyncSnapshot<Homepage> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.currentlyReadingWidget(context);
                } else if (snapshot.hasError) {
                  return Text('ERROR: ${snapshot.error}');
                } else {
                  return SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  );
                }
              }
            ),
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
