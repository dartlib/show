import 'package:flutter/material.dart';
import 'package:show/show.dart';

import 'showcase.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Builder(
        builder: (_) => MasterDetailContainer(
          items: showCases(),
        ),
      ),
    );
  }
}
