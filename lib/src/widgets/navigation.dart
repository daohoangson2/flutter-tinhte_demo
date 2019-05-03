import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tinhte_api/navigation.dart' as navigation;

import '../screens/forum_view.dart';
import '../screens/node_view.dart';
import '../api.dart';
import '_list_view.dart';

class NavigationWidget extends StatefulWidget {
  final Widget footer;
  final Widget header;
  final List<navigation.Element> initialElements;
  final String path;

  NavigationWidget({
    this.footer,
    this.header,
    this.initialElements = const [],
    Key key,
    @required this.path,
  }) : super(key: key);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  final List<navigation.Element> elements = List();

  bool _isFetching = false;

  int get itemCount =>
      (widget.header != null ? 1 : 0) +
      (_isFetching ? 1 : elements.length) +
      (widget.footer != null ? 1 : 0);

  @override
  void initState() {
    super.initState();

    elements.addAll(widget.initialElements);

    fetch();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemBuilder: (context, i) {
          if (widget.header != null && i == 0) return widget.header;

          if (widget.footer != null && i == itemCount - 1) return widget.footer;

          if (_isFetching) return buildProgressIndicator(true);

          return _buildRow(elements[i - (widget.header != null ? 1 : 0)]);
        },
        itemCount: itemCount,
      );

  fetch() {
    if (_isFetching) return;
    setState(() => _isFetching = true);

    apiGet(
      this,
      widget.path,
      onSuccess: (jsonMap) {
        List<navigation.Element> newElements = List();

        if (jsonMap.containsKey('elements')) {
          final list = jsonMap['elements'] as List;
          list.forEach((j) => newElements.add(navigation.Element.fromJson(j)));
        }

        setState(() => elements.addAll(newElements));
      },
      onComplete: () => setState(() => _isFetching = false),
    );
  }

  Widget _buildRow(navigation.Element e) => ListTile(
        title: Text(e.node?.title ?? "#${e.navigationId}"),
        onTap: () {
          switch (e.navigationType) {
            case navigation.NavigationTypeCategory:
              if (e.hasSubElements) {
                Navigator.push(
                  context,
                  NavigationRoute((_) => NodeViewScreen(element: e)),
                );
              }
              break;
            case navigation.NavigationTypeForum:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ForumViewScreen(e.node)),
              );
              break;
            case navigation.NavigationTypeLinkForum:
              final linkForum = e.node as navigation.LinkForum;
              final url = linkForum.links.target;
              canLaunch(url).then((ok) => ok ? launch(url) : null);
              break;
            default:
              Navigator.pushNamed(context, e.navigationType);
          }
        },
      );
}

class NavigationRoute extends MaterialPageRoute {
  NavigationRoute(WidgetBuilder builder) : super(builder: builder);
}
