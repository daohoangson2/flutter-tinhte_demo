import 'package:flutter/material.dart';
import 'package:tinhte_demo/src/widgets/x_user_feed.dart';

class MyFeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('My Feed'),
        ),
        body: UserFeedItems(),
      );
}
