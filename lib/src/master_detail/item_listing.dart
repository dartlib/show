import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:show/src/utils/uuid.dart';

import '../showcase_item.dart';

class ItemListing extends StatelessWidget {
  final Set<ShowCaseItem> items;
  ItemListing({
    @required this.itemSelectedCallback,
    @required this.items,
    this.selectedItem,
  });

  final ValueChanged<int> itemSelectedCallback;
  final ShowCaseItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    var i = -1;
    return Column(
        children: items.map(
      (showCase) {
        final index = ++i;

        return ListTile(
          key: Key(uuid()),
          onTap: () => itemSelectedCallback(index),
          selected: selectedItem == showCase,
          title: Text(
            showCase.title ?? 'No Title',
            style: textTheme.subtitle,
          ),
        );
      },
    ).toList());
  }
}
