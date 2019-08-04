import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:show/show.dart';
import 'package:show/src/tree_view/tree_item.dart';
import 'package:show/src/tree_view/tree_node.dart';
import 'package:show/src/tree_view/tree_view.dart';

import '../showcase_item.dart';

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
      children: _getChildList(
        items.map((showCase) {
          return TreeNode(
            index: index++,
            name: showCase.title,
          )..addAll(showCase.items);
        }).toList(),
      ),
    );
  }

  List<Widget> _getChildList(List<TreeNode> childTreeNodes) {
    return childTreeNodes.map((node) {
      if (node.isLeafNode) {
        return Container(
          margin: const EdgeInsets.only(left: 8),
          child: TreeViewChild(
            parent: TreeItem(node: node),
            onTap: itemSelectedCallback,
            children: _getChildList(node.children),
          ),
        );
      }
      return Container(
        margin: const EdgeInsets.only(left: 4),
        child: TreeViewChild(
          parent: TreeItem(node: node),
          children: _getChildList(node.children),
        ),
      );
    }).toList();
  }
}
