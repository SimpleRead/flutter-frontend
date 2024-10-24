import 'package:flutter/material.dart';
import 'package:simpleread/api.dart';
import 'package:simpleread/auth.dart';
import 'package:simpleread/appbar.dart';
import 'package:simpleread/settings.dart';
import 'package:simpleread/container.dart';

enum _RowType {
  CURRENT,
  RECOMMENDED,
}

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
      appBar: AppBar(
        title: SimplereadBar(),
        centerTitle: true,
      ),
      body: <Widget>[
        /// Home page
        ListView(
          children: [
            Text("Currently reading:", style: theme.textTheme.titleLarge),
            FutureBuilder<Homepage>(
              future: homePage,
              builder: (BuildContext context, AsyncSnapshot<Homepage> snapshot) {
                return _bookRowFromFuture(context, snapshot, token, _RowType.CURRENT);
              }
            ),
            Text("Recommended:", style: theme.textTheme.titleLarge),
            FutureBuilder<Homepage>(
              future: homePage,
              builder: (BuildContext context, AsyncSnapshot<Homepage> snapshot) {
                return _bookRowFromFuture(context, snapshot, token, _RowType.RECOMMENDED);
              }
            ),
          ]
        ),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                "TODO: Implement me",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),
        SimplereadSettings(sharedState),
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
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.settings)),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _bookRowFromFuture(BuildContext context, AsyncSnapshot<Homepage> snapshot,
      AuthToken token, _RowType type) {
    Widget content;
    if (snapshot.hasData) {
      Homepage h = snapshot.data!;
      String Function(int) nthBook;
      void Function(int) clickBook;
      int numBooks;
      List<Widget> rowWidgets = [];
      switch (type) {
      case _RowType.CURRENT:
        nthBook = (int n) {
          return h.currentlyReading[n].book;
        };
        clickBook = (int n) {
          sharedState.experience = h.currentlyReading[n];
          sharedState.switchPage(SimplereadPage.PREVIEW_EXPERIENCE);
        };
        numBooks = h.currentlyReading.length;
        break;
      case _RowType.RECOMMENDED:
        nthBook = (int n) {
          return h.recommended[n];
        };
        clickBook = (int n) {
          sharedState.book = h.recommended[n];
          sharedState.switchPage(SimplereadPage.PREVIEW_BOOK);
        };
        numBooks = h.recommended.length;
        break;
      }
      for (int i = 0; i < numBooks; ++i) {
        String bookGuid = nthBook(i);
        Future<Book> book = token.fetchBook(bookGuid);
        rowWidgets.add(FutureBuilder<Book>(
          future: book,
          builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
            if (snapshot.hasData) {
              Book book = snapshot.data!;
              return InkWell(
                onTap: () => clickBook(i),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        width: THUMBNAIL_WIDTH.toDouble(),
                        height: THUMBNAIL_HEIGHT.toDouble(),
                        child: token!.getThumbnail(book),
                      ),
                      Container(
                        width: THUMBNAIL_WIDTH.toDouble(),
                        child: Text(
                          book.work.title,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return SizedBox(
                width: THUMBNAIL_WIDTH + 20,
                height: THUMBNAIL_WIDTH + 40,
                child: Text('ERROR: ${snapshot.error}'),
              );
            } else {
              return SizedBox(
                width: THUMBNAIL_WIDTH + 20,
                height: THUMBNAIL_WIDTH + 40,
                child: Text("Loading..."),
              );
            }
          }
        ));
      }
      content = Container(
        height: THUMBNAIL_HEIGHT + 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: rowWidgets,
        ),
      );
    } else if (snapshot.hasError) {
      content = Text('ERROR: ${snapshot.error}');
    } else {
      content = SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: content,
    );
  }
}
