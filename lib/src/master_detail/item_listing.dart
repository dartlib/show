import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:show/show.dart';

import '../showcase_item.dart';
import '../tree_view/tree_node.dart';
import '../tree_view/tree_view.dart';

class ItemListing extends StatelessWidget {
  final Set<ShowCase> items;
  ItemListing({
    @required this.itemSelectedCallback,
    @required this.items,
    this.selectedItem,
  });

  final TreeItemCallback itemSelectedCallback;
  final ShowCaseItem selectedItem;

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return TreeView(
      startExpanded: true,
      onTap: itemSelectedCallback,
      children: items.map((showCase) {
        return TreeNode(
          index: index++,
          name: showCase.title,
        )..addAll(_buildChildren(showCase.items));
      }).toList(),
    );
  }

  List<TreeNode> _buildChildren(Set<ShowCaseItem> items) {
    var index = 0;
    return items.map((item) {
      return TreeNode(
        name: item.title,
        index: index++,
      );
    }).toList();
  }
}
