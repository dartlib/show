import 'package:flutter/material.dart';

import 'tree_node.dart';

class TreeItem extends StatelessWidget {
  final TreeNode node;
  final VoidCallback onPressedNext;

  TreeItem({
    @required this.node,
    this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: ListTile(
        leading: !node.isLeafNode
            ? const Icon(Icons.folder)
            : Icon(Icons.insert_drive_file),
        title: Text(node.name),
        trailing: !node.isLeafNode
            ? IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: onPressedNext,
              )
            : null,
      ),
    );
  }
}
