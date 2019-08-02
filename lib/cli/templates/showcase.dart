String showCaseTemplate() {
  return '''
import 'package:flutter/material.dart';
import 'package:show/show.dart';

import 'showcase.g.dart';

void main() async {
  return runApp(
    MaterialApp(
      home: MasterDetailContainer(
        title: const Text('ShowCase'),
        items: showCases,
      ),
    ),
  );
}
''';
}
