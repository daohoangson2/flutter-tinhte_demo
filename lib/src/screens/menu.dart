import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tinhte_demo/src/intl.dart';
import 'package:tinhte_demo/src/screens/notification_list.dart';
import 'package:tinhte_demo/src/widgets/menu/dark_theme.dart';
import 'package:tinhte_demo/src/widgets/app_bar.dart';
import 'package:tinhte_demo/src/link.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(l(context).menu),
        ),
        body: ListView(
          children: <Widget>[
            AppBarDrawerHeader(),
            MenuDarkTheme(),
            _buildNotifications(context),
            AppBarDrawerFooter(),
            _buildPrivacyPolicy(context),
            _PackageInfoWidget(),
          ],
        ),
      );

  Widget _buildNotifications(BuildContext context) => ListTile(
        title: Text(l(context).notifications),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => NotificationListScreen())),
      );

  Widget _buildPrivacyPolicy(BuildContext context) => ListTile(
        title: Text(l(context).privacyPolicy),
        onTap: () => launchLink(context, 'https://tinhte.vn/threads/2864415/'),
      );
}

class _PackageInfoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PackageInfoState();
}

class _PackageInfoState extends State<_PackageInfoWidget> {
  PackageInfo _info;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) => setState(() => _info = info));
  }

  @override
  Widget build(BuildContext context) => ListTile(
      title: Text(l(context).appVersion),
      subtitle: Text(_info != null
          ? l(context).appVersionInfo(_info.version, _info.buildNumber)
          : l(context).appVersionNotAvailable));
}
