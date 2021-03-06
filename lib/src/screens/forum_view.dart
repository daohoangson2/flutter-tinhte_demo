import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tinhte_api/node.dart';
import 'package:tinhte_demo/src/intl.dart';
import 'package:tinhte_demo/src/screens/search/thread.dart';
import 'package:tinhte_demo/src/screens/thread_create.dart';
import 'package:tinhte_demo/src/widgets/navigation.dart';
import 'package:tinhte_demo/src/widgets/threads.dart';

class ForumViewScreen extends StatefulWidget {
  final Forum forum;

  ForumViewScreen(this.forum, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForumViewScreenState();
}

class _ForumViewScreenState extends State<ForumViewScreen> {
  Forum get forum => widget.forum;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(forum.forumTitle),
        ),
        body: ThreadsWidget(
          forum: forum,
          header: NavigationWidget(
            path: "navigation?parent=${forum.forumId}",
            progressIndicator: false,
            shrinkWrap: true,
          ),
          path: "threads?forum_id=${forum.forumId}",
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: Icon(Icons.search),
              label: l(context).searchThisForum,
              onTap: () => showSearch(
                context: context,
                delegate: ThreadSearchDelegate(forum: forum),
              ),
            ),
            SpeedDialChild(
              child: Icon(FontAwesomeIcons.edit),
              label: l(context).threadCreateNew,
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ThreadCreateScreen(forum: forum))),
            ),
          ],
        ),
      );
}
