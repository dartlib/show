import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:show/src/api.dart';
import 'package:show/src/core/showcase_item.dart';

import '../showcase_item_widget.dart';

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
    final Widget showCaseItemWidget = ShowCaseItemWidget(
      api: Api.instance,
      showCaseItem: item,
      child: Builder(builder: (context) {
        final items = item.showCaseFactory(context);

        final children = items.map((Widget widget) {
          return item.decorator != null ? item.decorator(widget) : widget;
        }).toList();

        return item.layout(children);
      }),
    );

    if (isInTabletLayout) {
      Widget child;

      if (theme != null) {
        child = Theme(
          data: theme,
          child: showCaseItemWidget,
        );
      } else {
        child = showCaseItemWidget;
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
      body: Center(child: showCaseItemWidget),
    );
  }
}
