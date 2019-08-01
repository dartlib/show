import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../logger.dart';
import '../showcase_item.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({
    @required this.isInTabletLayout,
    @required this.item,
  });

  final bool isInTabletLayout;
  final ShowCaseItem item;

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return Center(
        child: const Text('Choose an item on the left'),
      );
    }

    final children = item.items.map((WidgetFactory factory) {
      return item.decorator != null ? item.decorator(factory()) : factory();
    }).toList();

    final Widget content = item.layout(children);

    if (isInTabletLayout) {
      return Column(
        children: [
          Expanded(
            flex: 5,
            child: content,
          ),
          Expanded(
              flex: 3,
              child: Card(
                child: Logger(),
              ))
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
