import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../showcase_item.dart';

/// Shows the showcase items within a given layout.
///
/// Optionally allows to set a theme, typically this is the theme of your application.
///
/// By default the widgets are rendered using the theme of the showCase application.
class ItemDetails extends StatelessWidget {
  final bool isInTabletLayout;
  final ShowCaseItem item;
  final ThemeData theme;

  ItemDetails({
    @required this.isInTabletLayout,
    @required this.item,
    this.theme,
  }) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    final items = item.showCaseFactory(context);

    final children = items.map((Widget widget) {
      return item.decorator != null ? item.decorator(widget) : widget;
    }).toList();

    final Widget content = Builder(builder: (context) => item.layout(children));

    if (isInTabletLayout) {
      Widget child;

      if (theme != null) {
        child = Theme(
          data: theme,
          child: content,
        );
      } else {
        child = content;
      }

      return Column(
        children: [
          Expanded(
            flex: 5,
            child: child,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Center(child: content),
    );
  }
}
