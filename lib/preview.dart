import 'package:flutter/material.dart';
import 'package:simpleread/api.dart';
import 'package:simpleread/auth.dart';
import 'package:simpleread/load.dart';
import 'package:simpleread/appbar.dart';
import 'package:simpleread/container.dart';
import 'package:float_column/float_column.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => sharedState.switchPage(SimplereadPage.HOME),
        ),
        centerTitle: true,
        title: SimplereadBar(),
      ),
      body: LoadingPage(child: _buildPreviewChild(context)),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  Future<Widget> _buildPreviewChild(BuildContext context) async {
    String bookGuid;
    final ThemeData theme = Theme.of(context);
    switch (sharedState.currPage) {
    case SimplereadPage.PREVIEW_EXPERIENCE:
      bookGuid = sharedState.experience!.book;
      break;
    case SimplereadPage.PREVIEW_BOOK:
      bookGuid = sharedState.book!;
      break;
    default:
      throw new AssertionError('Invalid preview type ${sharedState.currPage}');
      break;
    }
    Book book = await sharedState.token!.fetchBook(bookGuid);
    List<Widget> items = [];
    var image = sharedState.token!.getThumbnail(book);
    var title = Flexible(
      child: Text(
        book.work.title,
        textScaler: TextScaler.linear(2),
      ),
    );
    var header = FloatColumn(
      children: [RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Floatable(
                float: FCFloat.start,
                padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: sharedState.token!.getThumbnail(book),
              ),
            ),
            TextSpan(
              text: book.work.title,
              style: theme.textTheme.displaySmall,
            ),
            TextSpan(text: "\n"),
            TextSpan(
              text: book.work.synopsis,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      )],
    );
    items.add(header);
    return ListView(
      padding: EdgeInsets.all(16),
      children: items,
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {print("Pressed!");},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          minimumSize: Size.fromHeight(50),
        ),
        child: Text("Play movie"),
      ),
      padding: EdgeInsets.only(bottom: 8.0),
    );
  }
}
