import 'package:flutter/material.dart';

import 'tree_item.dart';
import 'tree_node.dart';
import 'tree_view_child.dart';
import 'tree_view_data.dart';

typedef TreeItemCallback = Function(TreeNode node);

class TreeView extends StatefulWidget {
  final List<TreeNode> children;
  final bool startExpanded;
  final TreeItemCallback onTap;

  TreeView({
    Key key,
    @required this.children,
    @required this.onTap,
    this.startExpanded = false,
  }) : super(key: key);

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  int activeNodeIndex;

  @override
  @override
  Widget build(BuildContext context) {
    return TreeViewData(
      children: _getChildList(widget.children, widget.onTap),
    );
  }

  List<Widget> _getChildList(
      List<TreeNode> childTreeNodes, TreeItemCallback onTap) {
    return childTreeNodes.map((node) {
      if (node.isLeafNode) {
        return Container(
          margin: const EdgeInsets.only(left: 8),
          child: TreeViewChild(
            parent: TreeItem(
              node: node,
              expanded: activeNodeIndex == node.index,
            ),
            active: activeNodeIndex == node.index,
            onTap: _onTap,
            children: _getChildList(node.children, onTap),
          ),
        );
      }
      return Container(
        margin: const EdgeInsets.only(left: 4),
        child: TreeViewChild(
          onTap: _onTap,
          parent: TreeItem(
            node: node,
            expanded: activeNodeIndex == node.index,
          ),
          active: activeNodeIndex == node.index,
          children: _getChildList(node.children, onTap),
        ),
      );
    }).toList();
  }

  void _onTap(TreeNode node) {
    if (node.isLeafNode) {
      widget.onTap(node);
    } else {
      setState(() {
        if (activeNodeIndex == node.index) {
          activeNodeIndex = null;
        } else {
          activeNodeIndex = node.index;
        }
      });
    }
  }
}
