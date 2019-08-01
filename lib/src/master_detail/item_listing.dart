import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../showcase_item.dart';

class ItemListing extends StatelessWidget {
  final Set<ShowCaseItem> items;
  ItemListing({
    @required this.itemSelectedCallback,
    @required this.items,
    this.selectedItem,
  });

  final ValueChanged<ShowCaseItem> itemSelectedCallback;
  final ShowCaseItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
        children: items.map(
      (showCase) {
        return Column(
          children: [
            ListTile(
              onTap: () => itemSelectedCallback(showCase),
              selected: selectedItem == showCase,
              title: Text(
                showCase.title ?? 'No Title',
                style: textTheme.display3,
              ),
            ),
          ],
        );
      },
    ).toList());
  }
}
