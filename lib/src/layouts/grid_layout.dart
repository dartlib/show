import 'package:flutter/material.dart';
import 'package:show/src/utils/uuid.dart';

import 'showcase_layout.dart';

class GridLayout extends ShowCaseLayout {
  GridLayout({
    List<Widget> children,
  }) : super(children: children);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 3,
        padding: const EdgeInsets.all(10),
        crossAxisCount: 3,
        children: children
            .map((widget) => Container(
                  key: Key(uuid()),
                  child: widget,
                ))
            .toList(),
      ),
    );
  }
}
