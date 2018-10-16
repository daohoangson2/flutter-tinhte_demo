import 'package:flutter/material.dart';

import 'package:tinhte_api/api.dart';
import 'src/screens/home.dart';
import 'src/widgets/_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final api = Api('https://tinhte.vn/appforo/index.php', '', '');
    api.httpHeaders['Api-Bb-Code-Chr'] = '1';

    return ApiInheritedWidget(
        api: api,
        child: MaterialApp(
          title: 'Tinh tế Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: SafeArea(child: HomeScreen(title: 'Tinh tế Home (demo)')),
        ));
  }
}
